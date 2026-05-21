// "Client Employee Master"
report 58190 "Client Empl. Master Update"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = updateClient;

    dataset
    {
        dataitem("Client Employee Master"; "Client Employee Master")
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                Validate(Level);
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

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    rendering
    {
        layout(updateClient)
        {
            Type = RDLC;
            LayoutFile = './src/report_layout/UpdateClient.rdl';
        }
    }

    var
        myInt: Integer;
}