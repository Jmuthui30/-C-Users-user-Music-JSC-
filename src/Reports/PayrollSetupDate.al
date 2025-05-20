report 52020 "Payroll Deduction SetupDate"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Ded Update';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/PayrollDedSetup.rdl';

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
                    if (ClientEmployeeMaster."Employee Group" = 'JSC') or (ClientEmployeeMaster."Employee Group" = 'KJA') then begin
                        repeat
                            ClientDeductionApp.Reset();
                            ClientDeductionApp.SetRange(ClientDeductionApp."Employee No", ClientEmployeeMaster."No.");
                            if ClientDeductionApp.Find('-') then begin
                                ClientDeductionApp.Code := PayrollCode;
                                ClientDeductionApp.Modify(true);
                                ClientDeductionApp.Validate(Code);
                            end;
                        until ClientEmployeeMaster.next = 0;
                    end;

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