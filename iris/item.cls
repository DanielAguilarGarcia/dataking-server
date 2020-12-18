Class dataking.storage.item Extends (%Persistent, %JSON.Adaptor, %Populate)
{

Property Type As %VarString;

Property Event As %String;

Property Data As %VarString;

Property CreatedAt As %Date;

ClassMethod Insert(type, event, data) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set item = ..%New()
    set item.Type = type
    Set item.Event = event
    Set item.Data = data
    Set item.CreatedAt = $P($H,",")

    set tSC = item.%Save()

    Quit tSC
}

}