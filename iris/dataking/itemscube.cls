/// 
Class dataking.itemscube Extends %DeepSee.CubeDefinition [ DependsOn = dataking.storage.item, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="Items" displayName="Items" disabled="false" abstract="false" sourceClass="dataking.storage.item" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Event" disabled="false" hasAll="false" allCaption="All Event" allDisplayName="Event" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Event" disabled="false" sourceProperty="Event" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Type" disabled="false" hasAll="false" allCaption="All Type" allDisplayName="Type" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Type" disabled="false" sourceProperty="Type" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="CreatedAt" disabled="false" hasAll="false" allCaption="All CreatedAt" allDisplayName="CreatedAt" sourceProperty="CreatedAt" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="Day" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="User_id" disabled="false" hasAll="false" allCaption="All Data" allDisplayName="Data" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="User_id" disabled="false" sourceExpression="$$%EvaluatePathOne^%DocDB.Document(%source.Data,&quot;$.user_id&quot;)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Cmd" disabled="false" hasAll="false" allCaption="All Data1" allDisplayName="Data1" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Cmd" disabled="false" sourceExpression="$$%EvaluatePathOne^%DocDB.Document(%source.Data,&quot;$.cmd&quot;)" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
    </hierarchy>
  </dimension>
  <listing name="Data" disabled="false" listingType="table" fieldList="Type,Event,Data,CreatedAt,%ID">
  </listing>
</cube>
}

Parameter DOMAIN;

}
