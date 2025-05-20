table 51608 "Performance Appraisal"
{
    fields
    {
        field(1; "Employee No"; Code[30])
        {
            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee No")then begin
                    "Mobile No":=NAVemp."Mobile Phone No.";
                    "Employment Date":=NAVemp."Employment Date";
                    "Employee Name":=NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                    "Job Title":=NAVemp."Job Title";
                    Validate(Manager, NAVemp."Manager No.");
                end;
                "No.":="Employee No" + Format(Date2DMY("Review Start Date", 2)) + Format(Date2DMY("Review Start Date", 3)) + '-' + Format(Date2DMY("Review End Date", 2)) + Format(Date2DMY("Review End Date", 3));
            end;
        }
        field(2; "Review Start Date"; Date)
        {
        }
        field(3; "Review End Date"; Date)
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; "Employee Name"; Text[100])
        {
        }
        field(6; "Job Title"; Text[50])
        {
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(9; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(10; Manager; Code[20])
        {
            trigger OnValidate()
            begin
                if NAVemp.Get(Manager)then "Manager's Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            end;
        }
        field(11; "Manager's Name"; Text[100])
        {
        }
        field(12; "Created By"; Code[50])
        {
        }
        field(13; "Mobile No"; Text[20])
        {
        }
        field(14; "Employment Date"; Date)
        {
        }
        field(15; "Due Date"; Date)
        {
        }
        field(16; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(17; Closed; Boolean)
        {
            trigger OnValidate()
            begin
                "Closed By":=UserId;
                "Closed Date":=Today;
            end;
        }
        field(18; "Closed By"; Code[50])
        {
        }
        field(19; "Closed Date"; Date)
        {
        }
        field(20; Archived; Boolean)
        {
            trigger OnLookup()
            begin
                "Archived By":=UserId;
                "Archived Date":=Today;
            end;
        }
        field(21; "Archived By"; Code[50])
        {
        }
        field(22; "Archived Date"; Date)
        {
        }
        field(23; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "No."; Code[30])
        {
        }
        field(25; "Appraisee Score Section A"; Decimal)
        {
            CalcFormula = Sum("Appraisal Details Quantitative"."Score (Appraisee)" WHERE("Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date")));
            Caption = 'Score';
            FieldClass = FlowField;
        }
        field(26; "Appraiser Score Section A"; Decimal)
        {
            CalcFormula = Sum("Appraisal Details Quantitative"."Score (Reviewer)" WHERE("Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date")));
            Caption = 'Score';
            FieldClass = FlowField;
        }
        field(27; Strengths; Text[250])
        {
        }
        field(28; Weaknesses; Text[250])
        {
        }
        field(29; "Areas of Improvement"; Text[250])
        {
        }
        field(30; "1st Quarter Score"; Decimal)
        {
            trigger OnValidate()
            begin
                AvgScore:=0;
                if "2nd Quarter Score" <> 0 then begin
                    Total:="1st Quarter Score" + "2nd Quarter Score";
                    AvgScore:=Round((Total / 200) * 100, 0.01);
                    if AvgScore > 95 then "Grade Score":=5
                    else if(AvgScore > 90) and (AvgScore < 96)then "Grade Score":=4
                        else if(AvgScore > 80) and (AvgScore < 91)then "Grade Score":=3
                            else if(AvgScore > 69) and (AvgScore < 81)then "Grade Score":=2
                                else if(AvgScore > 59) and (AvgScore < 70)then "Grade Score":=1
                                    else if(AvgScore < 60)then "Grade Score":=0;
                end;
            end;
        }
        field(31; "2nd Quarter Score"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("1st Quarter Score");
            end;
        }
        field(32; Total; Decimal)
        {
        }
        field(33; "Grade Score"; Decimal)
        {
        }
        field(34; "Courses Attended"; Text[250])
        {
        }
        field(35; "Traning Need"; Text[250])
        {
        }
        field(36; "Employee Qualifications"; Text[250])
        {
            Caption = 'Employee Qualifications as at date';
        }
        field(37; "Overal Performance Grade"; Option)
        {
            OptionCaption = ' ,A+ (80-100),A (70-79),B (60-69),C (50-59),F (0-49)';
            OptionMembers = " ", "A+ (80-100)", "A (70-79)", "B (60-69)", "C (50-59)", "F (0-49)";
        }
        field(38; "Reviewer's Comments"; Text[250])
        {
        }
        field(39; "Agreed with Appraiser"; Option)
        {
            Caption = 'I''ve read, understood, and agreed or disagreed with the scores and comments of the Appraiser';
            OptionCaption = 'Agreed,Disagree';
            OptionMembers = Agreed, Disagree;
        }
        field(40; "Disagreement Reasons"; Text[250])
        {
        }
        field(41; Recommendation; Option)
        {
            OptionCaption = ' ,Defer Confirmation,Confirm,Salary Increment,Promotion,Cautionary Letter,Warning Letter,Exit';
            OptionMembers = " ", "Defer Confirmation", Confirm, "Salary Increment", Promotion, "Cautionary Letter", "Warning Letter", "Exit";
        }
        field(42; "HOD Comments"; Text[250])
        {
        }
        field(43; "ED Comments"; Text[250])
        {
        }
        field(44; "MD/CEO Comments"; Text[250])
        {
        }
        field(45; "Date of Last Promotion"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No", "Review Start Date", "Review End Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        Date:=Today;
        Status:=Status::Open;
        if UserSetup.Get(UserId)then begin
            "Employee No":=UserSetup."Employee No.";
            AppraisalSetup.Reset;
            AppraisalSetup.SetCurrentKey(Activated);
            AppraisalSetup.SetRange(Activated, true);
            if AppraisalSetup.FindFirst then begin
                "Review Start Date":=AppraisalSetup."Review Start Date";
                "Review End Date":=AppraisalSetup."Review End Date";
                "Due Date":=AppraisalSetup."Due Date for Appraisees";
                "No.":="Employee No" + Format(Date2DMY("Review Start Date", 2)) + Format(Date2DMY("Review Start Date", 3)) + '-' + Format(Date2DMY("Review End Date", 2)) + Format(Date2DMY("Review End Date", 3));
                //Initialize Questions
                PerformanceMgt.InitializeQuestions(Rec);
            //
            end
            else
                Error(Text001);
            Validate("Employee No");
        end
        else
            Error(Text000);
        "Created By":=UserId;
    end;
    var UserSetup: Record "User Setup";
    EmpRec: Record "Employee Master";
    NAVemp: Record Employee;
    AppraisalSetup: Record "Appraisal Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    Text001: Label 'Appraisal has not been opened for any period. Kindly contact the HR department';
    PerformanceMgt: Codeunit "Performance Management";
    AvgScore: Decimal;
}
