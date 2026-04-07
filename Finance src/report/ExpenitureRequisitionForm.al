

report 51244 "Expenditure Requisition Form"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RequisitionForm;

    dataset
    {
        dataitem("Imprest Memo Header"; "Imprest Memo Header")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }

            column(No_; "No.")
            {
            }
            column(Date; Date) { }
            column(From; From) { }
            column(To; "To") { }
            column(Purpose; Purpose) { }
            column(Created_By; "Created By") { }
            column(RunLine; RunLine)
            {

            }

            //Imprest Budget Analysis
            dataitem("Imprest Budget Analysis"; "Imprest Budget Analysis")
            {
                DataItemLink = "Memo No." = FIELD("No.");

                column(Memo_No_; "Memo No.") { }
                column(Budget_Line; "Budget Line") { }
                column(Description; Description) { }
                column(Amount_on_Budget; "Amount on Budget") { }
                column(Committed_Amount; "Committed Amount") { }
                column(Amount_Required; "Amount Required") { }
                column(Available_Balance; "Available Balance") { }
                column(Budget_Availability; "Budget Availability") { }
                column(BudgetLine; BudgetLine)
                { }
                trigger OnAfterGetRecord()
                begin
                    BudgetLine := BudgetLine + 1;
                end;

            }
            dataitem("Imprest Memo Lines"; "Imprest Memo Lines")
            {
                DataItemLink = "No." = FIELD("No.");
                column(No_Line; "No.") { }
                column(Type; Type) { }
                column(Account_No_; "Account No.") { }
                column(Name; Name) { }

                column(Amount; Amount) { }
                column(MemoLine; MemoLine) { }
                trigger OnAfterGetRecord()
                begin
                    MemoLine := MemoLine + 1;
                end;


            }

            trigger OnAfterGetRecord()
            begin
                RunLine := RunLine + 1;
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
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(LayoutName)
                // {

                // }
            }
        }
    }

    rendering
    {
        layout(RequisitionForm)
        {
            //  applicationArea = All;
            Type = RDLC;

            LayoutFile = './Finance src/report_layout/RequisitionForm.rdl';
        }
    }

    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";
        BudgetLine: Integer;
        MemoLine: Integer;
        RunLine: Integer;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;
}