page 52435 "Portal Users"
{
    ApplicationArea = All;
    Caption = 'Portal Users';
    PageType = List;
    SourceTable = HRPortalUsers;
    UsageCategory = Lists;
    DeleteAllowed = true;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(employeeName; Rec.employeeName)
                {
                    ToolTip = 'Specifies the value of the employeeName field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.', Comment = '%';
                }
                field(changedPassword; Rec.changedPassword)
                {
                    ToolTip = 'Specifies the value of the changedPassword field.', Comment = '%';
                }
                field(employeeNo; Rec.employeeNo)
                {
                    ToolTip = 'Specifies the value of the employeeNo field.', Comment = '%';
                }
                field(password; Rec.password)
                {
                    ToolTip = 'Specifies the value of the password field.', Comment = '%';
                }
                field(IdNo; Rec.IdNo)
                {
                    ToolTip = 'Specifies the value of the IdNo field.', Comment = '%';
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ToolTip = 'Specifies the value of the Authentication Email field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GenerateP92)
            {
                Caption = 'Generate P92 (76653)';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Base64Pdf: Text;
                    StartDateTime: DateTime;
                    EndDateTime: DateTime;
                    TempBlob: Codeunit "Temp Blob";
                    OutStr: OutStream;
                    InStr: InStream;
                    FileName: Text;
                    Base64Convert: Codeunit "Base64 Convert";
                    HRPortal: Codeunit HRPortal;
                begin
                    // Hardcoded dates for 2025
                    StartDateTime := CreateDateTime(DMY2DATE(1, 1, 2025), 0T);
                    EndDateTime := CreateDateTime(DMY2DATE(31, 12, 2025), 235959T);

                    // Call your function
                    Base64Pdf := HRPortal.FAWEgenerateP92('76653', StartDateTime, EndDateTime);

                    Message(Base64Pdf);
                    if Base64Pdf = 'Report not found.' then begin
                        Message(Base64Pdf);
                        exit;
                    end;

                    // // Convert Base64 back to PDF stream
                    // TempBlob.CreateOutStream(OutStr);
                    // Base64Convert.FromBase64(Base64Pdf, OutStr);

                    // TempBlob.CreateInStream(InStr);

                    // FileName := 'P92_76653_2025.pdf';

                    // DownloadFromStream(InStr, '', '', '', FileName);
                end;
            }
        }
    }
}
