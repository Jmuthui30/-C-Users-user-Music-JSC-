report 51845 "Promotion History"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        SourceTable = "Company Jobs";

        layout
        {
            area(content)
            {
                group(General)
                {
                    field("Employee No."; "Emp_No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Details)
                {
                    field("Establishment"; JobPosition)
                    {
                        ApplicationArea = All;
                        TableRelation = "Company Jobs";
                    }
                    field("Start Date"; "Start Date")
                    {
                        ApplicationArea = All;
                    }
                    field("HR Remarks"; HR_Remarks)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
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
    trigger OnPreReport()
    begin
        if "Emp_No." = '' then Error('Employee No Wasnt Captured');
        if JobPosition = '' then Error('Establishment Field Must not be blank');
        if("Start Date" = 0D)then Error('Start Date Field Must not be blank');
        if("Start Date" > Today)then Error('Start Date Cannot Exceeds Todays Date');
        if Emp.Get("Emp_No.")then position:=Emp.Position;
        if(position = JobPosition)then Error('The Employee is Already in that Position');
        PromotionRec.Reset;
        PromotionRec.SetRange("Employee No", "Emp_No.");
        PromotionRec.SetRange("End Date", 0D);
        PromotionRec.SetRange("Position Closed", false);
        if PromotionRec.FindLast then begin
            date:=PromotionRec."Start Date";
            if("Start Date" <= date)then Error('Start Date Cannot Exceeds The Previous Position Start Date')
            else
                PromotionHistory.ProcessPromotion_Second("Emp_No.", "Start Date", HR_Remarks, JobPosition);
        end
        else
        begin
            if Employee.Get("Emp_No.")then begin
                Employee.TestField("Employment Date");
                date2:=Employee."Employment Date";
            end;
            if("Start Date" < date2)then Error('The Start Date Cannot Exceeds the Employment Date')
            else
                PromotionHistory.ProcessPromotion_First("Emp_No.", "Start Date", HR_Remarks, JobPosition);
        end;
    end;
    var PromotionHistory: Codeunit "Promotion History";
    HR_Remarks: Text[250];
    "Start Date": Date;
    "Emp_No.": Code[20];
    JobPosition: Code[20];
    PromotionRec: Record "Promotion History";
    date: Date;
    date2: Date;
    Employee: Record Employee;
    position: Code[20];
    Emp: Record "Employee Master";
    procedure GetEmployee(EmployeeMaster: Record "Employee Master")
    begin
        //IF Employee.GET(EmployeeMaster."No.") THEN;
        "Emp_No.":=EmployeeMaster."No.";
        HR_Remarks:='';
        "Start Date":=0D;
        JobPosition:='';
    end;
}
