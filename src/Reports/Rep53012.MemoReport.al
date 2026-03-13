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
            column(From; From) { }
            column(Date; Date) { }
            column(Subject; Subject) { }
            column(Message_body; "Message body") { }
            column(Message_body_1; "Message body 1") { }
            column(Recipient_Name; "Recipient Name") { }
            column(Sender_Name; "Sender Name") { }
            dataitem("Imprest Memo Lines"; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                column(Account_No_;"Account No."){}
                column(No_Line; "No.") { }
                column(Name; Name) { }
                column(Title; Title) { }
                column(Amount; Amount) { }

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