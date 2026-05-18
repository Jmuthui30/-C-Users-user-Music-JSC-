report 53012 "Memo Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSRS/Imprest Memo Report.rdl';

    dataset
    {
        dataitem("Imprest Memo Header"; "Imprest Memo Header")
        {
            column(CompInfoLogo; CompInfo.Picture)
            { }
            column(CompInfoName; CompInfo.Name) { }
            column(CompInfoAddress; CompInfo.Address) { }

            column(No_; "No.")
            {

            }
            column(To; "To")
            { }
            column(From_Title; "From Title")
            { }
            column(Recipient_Title; "Recipient Title") { }
            column(From; From) { }
            column(Date; Date) { }
            column(Subject; Subject) { }
            column(Message_body; "Message body") { }
            column(Message_body_1; "Message body 1") { }
            column(Recipient_Name; "Recipient Name") { }
            column(Sender_Name; "Sender Name") { }
            column(Total_Days_in_the_Field; "Total Days in the Field") { }
            dataitem("Imprest Memo Lines"; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                column(Account_No_; "Account No.") { }
                column(Name; Name) { }
                column(Title; Title) { }
                column(Amount; Amount) { }
                column(Other_Costs; "Other Costs") { }
                column(Description; Description) { }
                column(No_of_Days; "Total Days in the Field") { }

            }
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
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {

                //     }
                // }
            }
        }

        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {

            //     }
            // }
        }

    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        CompInfo: Record "Company Information";
}