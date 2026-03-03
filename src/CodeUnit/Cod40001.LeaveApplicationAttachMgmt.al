codeunit 52019 "Leave Application Attach Mgmt"
{
    // TableNo = "Leave Application";

    // trigger OnRun()
    // begin

    // end;
    Permissions = tabledata "Leave Application" = rimd;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterTableHasNumberFieldPrimaryKey', '', false, false)]
    local procedure HandleLeaveApplicationNumberField(TableNo: Integer; var Result: Boolean; var FieldNo: Integer)
    begin
        if TableNo <> Database::"Leave Application" then
            exit;

        FieldNo := 1;
        Result := true;
    end;

}
