const path = require('path');
const uniqid = require('uniqid');
const ws = new require('ws');
const DataStorage = require(path.join(__dirname, './data-storage'));
const pidusage = require('pidusage');

const APP_PORT = process.env.APP_PORT || 3001;

const App = function () {
    console.log('process: ', process.pid);
    const data_storage = new DataStorage();
    this.clients = {};

    this.initWSReceiver = function () {
        "use strict";

        let web_socket_server = new ws.Server({
            port: APP_PORT
        });
        web_socket_server.on('connection', (ws) => {
            const id = uniqid();
            this.clients[id] = ws;
            console.log('new connection ' + id, ws._socket.remoteAddress);

            ws.on('message', (raw_data) => {
                const data = JSON.parse(raw_data);
                for (let i = 0; i < data.length; i++) {
                    let item = JSON.parse(data[i]);
                    if (!item['api_key'] || !this.checkApiKey(item['api_key'])) {
                        ws.send('Wrong api key');
                        continue;
                    }
                    data_storage.insert(item);
                }
            });

            ws.on('close', () => {
                console.log('' + id);
                delete this.clients[id];
            });
        });
    };

    this.checkApiKey = function (key) {
        return true;
    };

    this.init = function () {
        this.initWSReceiver();
        setInterval(() => {
            pidusage(process.pid, function (err, stats) {
                data_storage.insert({type:'system', event:'stats', data:stats});
            })
        }, 1000);
    };
};

(new App()).init();