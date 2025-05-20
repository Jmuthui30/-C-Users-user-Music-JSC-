report 51616 "Appraisal Form"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Appraisal Form.rdlc';

    dataset
    {
        dataitem("Appraisal Questions Entries"; "Appraisal Questions Entries")
        {
            RequestFilterFields = "Employee No", "Review Start Date", "Review End Date";

            column(Logo; CompInfo.Picture)
            {
            }
            column(DimOne; DimOne)
            {
            }
            column(DimTwo; DimTwo)
            {
            }
            column(DimThree; DimThree)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(GradeLevel; GradeLevel)
            {
            }
            column(EmploymentDate; EmploymentDate)
            {
            }
            column(DateOfLastPromotion; DateOfLastPromotion)
            {
            }
            column(JobTitle; JobTitle)
            {
            }
            column(ReviewPeriod; ReviewPeriod)
            {
            }
            column(Date; AppraisalDate)
            {
            }
            column(ManagersName; ManagersName)
            {
            }
            column(InstructionOne; InstructionOne)
            {
            }
            column(InstructionTwo; InstructionTwo)
            {
            }
            column(InstructionThree; InstructionThree)
            {
            }
            column(QNo; "Appraisal Questions Entries"."No.")
            {
            }
            column(Question; "Appraisal Questions Entries".Question + "Appraisal Questions Entries"."Further Explanation")
            {
            }
            column(Response; "Appraisal Questions Entries".Response + "Appraisal Questions Entries"."Further Response")
            {
            }
            column(MyRating; "Appraisal Questions Entries"."My Rating")
            {
            }
            column(ManagersRating; "Appraisal Questions Entries"."Manager's Rating")
            {
            }
            column(ManagersRemarks; "Appraisal Questions Entries"."Manager's Remarks")
            {
            }
            column(Instructions; "Appraisal Questions Entries"."Sub-Question Instructions")
            {
            }
            dataitem("Appraisal SubQuestions Entries"; "Appraisal SubQuestions Entries")
            {
                DataItemLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date"), "Main Question No."=FIELD("No.");
                MaxIteration = 0;

                column(SubQInstructions; "Appraisal SubQuestions Entries"."Sub-Question Instructions")
                {
                }
                column(SubQNo; "Appraisal SubQuestions Entries"."Sub-Question No.")
                {
                }
                column(SubQ; "Appraisal SubQuestions Entries".Question + "Appraisal SubQuestions Entries"."Further Explanation")
                {
                }
                column(SubQResponse; "Appraisal SubQuestions Entries".Response + "Appraisal SubQuestions Entries"."Further Response")
                {
                }
                column(SubQRating; "Appraisal SubQuestions Entries"."My Rating")
                {
                }
                column(SubQManagerRating; "Appraisal SubQuestions Entries"."Manager's Rating")
                {
                }
                column(SubQManagerRemarks; "Appraisal SubQuestions Entries"."Manager's Remarks")
                {
                }
                trigger OnPreDataItem()
                begin
                /*"Appraisal SubQuestions Entries".SETRANGE("Employee No","Appraisal Questions Entries"."Employee No");
                    "Appraisal SubQuestions Entries".SETRANGE("Review Start Date","Appraisal Questions Entries"."Review Start Date");
                    "Appraisal SubQuestions Entries".SETRANGE("Review End Date","Appraisal Questions Entries"."Review End Date");
                    "Appraisal SubQuestions Entries".SETRANGE("Main Question No.","Appraisal Questions Entries"."No.");*/
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //Get Appraisal Details
                Appraisal.Reset;
                Appraisal.SetRange(Appraisal."Employee No", "Appraisal Questions Entries"."Employee No");
                Appraisal.SetRange(Appraisal."Review Start Date", "Appraisal Questions Entries"."Review Start Date");
                Appraisal.SetRange(Appraisal."Review End Date", "Appraisal Questions Entries"."Review End Date");
                if Appraisal.FindFirst then begin
                    ReviewPeriod:=Format(Appraisal."Review Start Date", 0, 4) + ' to ' + Format(Appraisal."Review End Date", 0, 4);
                    if Emp.Get(Appraisal."Employee No")then begin
                        GradeLevel:=Emp.Scale + '-' + Emp.Level;
                    end;
                    EmployeeName:=Appraisal."Employee Name";
                    DimOne:=Appraisal."Global Dimension 1 Code";
                    DimTwo:=Appraisal."Global Dimension 2 Code";
                    DimThree:=Appraisal."Global Dimension 3 Code";
                    EmploymentDate:=Appraisal."Employment Date";
                    DateOfLastPromotion:=Appraisal."Date of Last Promotion";
                    JobTitle:=Appraisal."Job Title";
                    AppraisalDate:=Appraisal.Date;
                    ManagersName:=Appraisal."Manager's Name";
                end;
            end;
            trigger OnPostDataItem()
            begin
            /*Counter := Counter+1;
                IF Counter > 1 THEN
                  CurrReport.SKIP;*/
            end;
        }
    }
    requestpage
    {
        layout
        {
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        GeneralInstructions.Get;
        InstructionOne:=GeneralInstructions."Instruction One";
        InstructionTwo:=GeneralInstructions."Instruction Two";
        InstructionThree:=GeneralInstructions."Instruction Three";
    end;
    var CompInfo: Record "Company Information";
    GradeLevel: Text;
    ReviewPeriod: Text;
    Emp: Record "Employee Master";
    GeneralInstructions: Record "Appraisal General Instructions";
    InstructionOne: Text;
    InstructionTwo: Text;
    InstructionThree: Text;
    Counter: Integer;
    Appraisal: Record "Performance Appraisal";
    EmployeeName: Text;
    DimOne: Text;
    DimTwo: Text;
    DimThree: Text;
    EmploymentDate: Date;
    DateOfLastPromotion: Date;
    JobTitle: Text;
    AppraisalDate: Date;
    ManagersName: Text;
}
