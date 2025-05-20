report 52100 "Create Employee Customer AC"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Create Employee Customer Accounts';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                AdvancedFinanceSetup.Get;
                if AccountType = AccountType::Travels then begin
                    CustEmployeeMapping2.Reset();
                    CustEmployeeMapping2.SetRange("Account Type", CustEmployeeMapping2."Account Type"::Travels);
                    CustEmployeeMapping2.SetRange("Employee No.", Employee."No.");
                    if CustEmployeeMapping2.FindFirst() = false then begin
                        Customer.Init;
                        Customer.Validate("No.", NoSeriesMgt.GetNextNo(AdvancedFinanceSetup."Emp Travel Cust No. Series", Today, true));
                        Customer.Validate(Name, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name" + ' - Travels A/C');
                        Customer.Address:=Employee.Address;
                        Customer."Gen. Bus. Posting Group":=AdvancedFinanceSetup."Employee Bus Posting Group";
                        Customer."Customer Posting Group":=AdvancedFinanceSetup."Emp Travels Cust Posting Group";
                        Customer."Payment Terms Code":=AdvancedFinanceSetup."Employee Payment Terms";
                        Customer.Insert;
                        //
                        CustEmployeeMapping.Init;
                        CustEmployeeMapping."Account Type":=CustEmployeeMapping."Account Type"::Travels;
                        CustEmployeeMapping."Employee No.":=Employee."No.";
                        CustEmployeeMapping."Customer AC":=Customer."No.";
                        CustEmployeeMapping.Insert;
                        if EmpRec.Get(Employee."No.")then begin
                            EmpRec."Travels Customer Account":=Customer."No.";
                            EmpRec.Modify;
                        end;
                    end;
                end
                else if AccountType = AccountType::Advances then begin
                        CustEmployeeMapping2.Reset();
                        CustEmployeeMapping2.SetRange("Account Type", CustEmployeeMapping2."Account Type"::Advances);
                        CustEmployeeMapping2.SetRange("Employee No.", Employee."No.");
                        if CustEmployeeMapping2.FindFirst() = false then begin
                            Customer.Init;
                            Customer.Validate("No.", NoSeriesMgt.GetNextNo(AdvancedFinanceSetup."Emp Advances Cust No. Series", Today, true));
                            Customer.Validate(Name, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name" + ' - Advances A/C');
                            Customer.Address:=Employee.Address;
                            Customer."Gen. Bus. Posting Group":=AdvancedFinanceSetup."Employee Bus Posting Group";
                            Customer."Customer Posting Group":=AdvancedFinanceSetup."Emp Advance Cust Posting Group";
                            Customer."Payment Terms Code":=AdvancedFinanceSetup."Employee Payment Terms";
                            Customer.Insert;
                            //
                            CustEmployeeMapping.Init;
                            CustEmployeeMapping."Account Type":=CustEmployeeMapping."Account Type"::Advances;
                            CustEmployeeMapping."Employee No.":=Employee."No.";
                            CustEmployeeMapping."Customer AC":=Customer."No.";
                            CustEmployeeMapping.Insert;
                            //
                            //
                            if EmpRec.Get(Employee."No.")then begin
                                EmpRec."Advancess Customer Account":=Customer."No.";
                                EmpRec.Modify;
                            end;
                        end;
                    end;
                //
                Window.Update(1, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
            end;
            trigger OnPreDataItem()
            begin
                Window.Open(Text003, Names);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(AccountType; AccountType)
                {
                    ApplicationArea = All;
                    Caption = 'Account Type';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        Window.Close;
        Message(Text002);
    end;
    trigger OnPreReport()
    begin
        AdvancedFinanceSetup.Get;
        if AdvancedFinanceSetup."Emp Travel Cust No. Series" = '' then Error('Kindly Specify Employee Travel No Series');
        if AdvancedFinanceSetup."Emp Advances Cust No. Series" = '' then Error('Kindly Specify Employee Travel No Series');
        if AdvancedFinanceSetup."Emp Travels Cust Posting Group" = '' then Error(Text000);
        if AdvancedFinanceSetup."Emp Travel Receivables Account" = '' then Error(Text001);
        if AdvancedFinanceSetup."Employee Bus Posting Group" = '' then Error(Text004);
        if AdvancedFinanceSetup."Employee Payment Terms" = '' then Error(Text005);
        if Format(AccountType) = '' then Error('You must select Account Type!');
    end;
    var AdvancedFinanceSetup: Record "Advanced Finance Setup";
    Customer: Record Customer;
    Text000: Label 'Kindly specify Employee Customer Posting Group on the Advanced Finance Setup';
    Text001: Label 'Kindly specify the Employee Receivables Account on the Advanced Finance Setup';
    Customer2: Record Customer;
    Text002: Label 'Complete';
    Window: Dialog;
    Text003: Label 'Creating customer account for #####1';
    Names: Text;
    Text004: Label 'Kindly specify the Employee Business Posting on the Advanced Finance Setup';
    Text005: Label 'Kindly specify the Employee Payment Terms on the Advanced Finance Setup';
    CustEmployeeMapping: Record "Employee Customer Mapping";
    CustEmployeeMapping2: Record "Employee Customer Mapping";
    EmpRec: Record "Employee Master";
    AccountType: Option Travels, Advances;
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
