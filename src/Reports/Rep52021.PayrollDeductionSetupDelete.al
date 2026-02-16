report 52021 "Payroll Deduction SetupDelete"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Ded Delete lines';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/PayrollDed Delete.rdl';

    dataset
    {
        dataitem("Client Payroll Matrix"; "Client Payroll Matrix")
        {
            RequestFilterFields = Code, "Employee No";
            column(Code; Code)
            {

            }
            trigger OnAfterGetRecord()

            begin

                ClientEmployeeMaster.Reset();
                ClientEmployeeMaster.SetRange(ClientEmployeeMaster."No.", "Client Payroll Matrix"."Employee No");
                if ClientEmployeeMaster.Find('-') then begin
                    repeat
                        ClientDeductionApp.Reset();
                        ClientDeductionApp.SetRange(ClientDeductionApp.Code, PayrollCode);
                        ClientDeductionApp.SetRange(ClientDeductionApp."Employee No", ClientEmployeeMaster."No.");
                        ClientDeductionApp.DeleteAll();
                    until ClientEmployeeMaster.next = 0;
                end;
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PayrollCode; PayrollCode)
                    {
                        TableRelation = "Client Deductions".Code;
                        ApplicationArea = All;
                    }

                }
            }
        }


    }



    var
        myInt: Integer;
        PayrollCode: Code[50];
        ClientDeductionApp: Record "Client Payroll Matrix";
        ClientEmployeeMaster: Record "Client Employee Master";
}