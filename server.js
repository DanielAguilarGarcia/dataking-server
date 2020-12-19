const path = require('path');
const uniqid = require('uniqid');
const ws = new require('ws');
const DataStorage = require(path.join(__dirname, './data-storage'));
const pidusage = require('pidusage');

const APP_PORT = process.env.APP_PORT || 3001;
const APP_HOST = process.env.APP_HOST || '0.0.0.0';
const APP_STAT_HEARTBEAT = process.env.APP_STAT_HEARTBEAT || 5000;

const App = function () {
    console.log('process: ', process.pid);
    const data_storage = new DataStorage();
    this.clients = {};

    this.initWSReceiver = function () {
        "use strict";

        let web_socket_server = new ws.Server({
            port: APP_PORT,
            host: APP_HOST
        });

        web_socket_server.on('connection', (ws) => {
            const id = uniqid();
            this.clients[id] = ws;
            console.log('new connection ' + id, ws._socket.remoteAddress);

            ws.on('message', (raw_data) => {
                try {
                    const data = JSON.parse(raw_data);
                    data_storage.insert(data);
                } catch (e) {
                    console.error('parse incoming msg', e);
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
        }, APP_STAT_HEARTBEAT);
    };
};

(new App()).init();