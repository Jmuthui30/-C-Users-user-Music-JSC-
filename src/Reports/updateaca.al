report 53070 "update quo code"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Applupdate;

    dataset
    {
        //Qualification  "Applicants Qualification
        dataitem("Applicants Qualification"; "Applicants Qualification")
        {
            // RequestFilterFields = "Qualification Type", Code;
            column(Employee_No_; "Employee No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                AppQ.Reset();
                AppQ.SetRange(AppQ."Employee No.", "Employee No.");
                if AppQ.Find('-') then begin
                    if AppQ.Description = 'Other' then begin
                        repeat
                            AppQ.Description := Qualification;
                            AppQ.Modify()
                                             until AppQ.Next() = 0;

                    end;

                end;
                //*******************************************************************************


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

            }
        }
    }

    rendering
    {
        layout(Applupdate)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/update quo code.RDLC';
            Caption = 'Job Submitted';
        }
    }

    var
        myInt: Integer;
        AppQ: Record "Applicants Qualification";


        JobApplication: record "Job Application";
}