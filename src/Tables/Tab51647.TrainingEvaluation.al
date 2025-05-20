table 51647 "Training Evaluation"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee No"; Code[20])
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
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Employee Name"; Text[100])
        {
        }
        field(5; "Job Title"; Text[50])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(9; Manager; Code[20])
        {
            trigger OnValidate()
            begin
                if NAVemp.Get("Global Dimension 3 Code")then Manager:=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            end;
        }
        field(10; "Manager's Name"; Text[100])
        {
        }
        field(11; "Created By"; Code[50])
        {
        }
        field(12; "Mobile No"; Text[20])
        {
        }
        field(13; "Employment Date"; Date)
        {
        }
        field(14; "Due Date"; Date)
        {
        }
        field(15; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(16; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(18; "Training No."; Code[20])
        {
            TableRelation = "Training Nomination Header";

            trigger OnValidate()
            begin
                if Training.Get("Training No.")then begin
                    "Course Title":=Training."Training Title";
                    Venue:=Training."Training Venue";
                    Organizers:=Training.Organizers;
                    "Start Date":=Training."Start Date";
                    "End Date":=Training."End Date";
                end;
            end;
        }
        field(19; "Course Title"; Text[50])
        {
        }
        field(20; Venue; Text[30])
        {
        }
        field(21; "Start Date"; Date)
        {
        }
        field(22; "End Date"; Date)
        {
        }
        field(23; Organizers; Text[30])
        {
        }
        field(24; "Relevance of Course"; Option)
        {
            Caption = 'Is the course content relevant to your current job description?';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes, No;
        }
        field(25; "Learned Skill 1"; Text[30])
        {
        }
        field(26; "Learned Skill 2"; Text[30])
        {
        }
        field(27; "Learned Skill 3"; Text[30])
        {
        }
        field(28; "Material Covered"; Text[250])
        {
            Caption = 'Was an appropriate amount of material covered during the course?  If not, was too much material covered or too little?';
        }
        field(29; "Rate the Training"; Option)
        {
            Caption = 'To what extent do you expect this training will make a difference in the way you do your job?';
            OptionCaption = '1 - No Difference,2,3,4,5-Tremendous Difference';
            OptionMembers = "1 - No Difference", "2", "3", "4", "5-Tremendous Difference";
        }
        field(30; "Couse Content"; Option)
        {
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent, Good, "Not Good", Poor;
        }
        field(31; Notes; Option)
        {
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent, Good, "Not Good", Poor;
        }
        field(32; Presentation; Option)
        {
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent, Good, "Not Good", Poor;
        }
        field(33; "Relevance Rating"; Option)
        {
            Caption = 'Relevance';
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent, Good, "Not Good", Poor;
        }
        field(34; Recommend; Option)
        {
            Caption = 'Would you recommend the course for other staff ?';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes, No;
        }
        field(35; Comments; Text[250])
        {
        }
        field(36; "HR Comments"; Text[250])
        {
        }
        field(37; "Name of Facilitator"; Text[50])
        {
        }
        field(38; "Clear objectives"; Decimal)
        {
            Caption = 'Clear objectives (Scale of 1 - 10)';
        }
        field(39; Organization; Decimal)
        {
            Caption = 'Organisation of content (introduction, body, conclusion)';
        }
        field(40; Ease; Decimal)
        {
            Caption = 'Ease of Understanding (clear, concise)';
        }
        field(41; Usefulness; Decimal)
        {
            Caption = 'Usefulness of content (informative and current)';
        }
        field(42; "Meeting Objectives"; Decimal)
        {
            Caption = 'Meeting course objectives';
        }
        field(43; "Addresses Non-compliance"; Decimal)
        {
            Caption = 'Addresses non-compliance (lateness, non-participation, disorderly conduct)';
        }
        field(44; "Participants Engagement"; Decimal)
        {
            Caption = 'Participants engagement (trainer-trainee interactions)';
        }
        field(45; "Pratical Examples"; Decimal)
        {
            Caption = 'Use of Practical examples (or clear explanations)';
        }
        field(46; "Pro-social behaviour"; Decimal)
        {
            Caption = 'Encourages pro-social behaviour (audience maintenance)';
        }
        field(47; "Constructive Feedback"; Decimal)
        {
            Caption = 'Providing Constructive feedback (satisfactory answers)';
        }
        field(48; "Use of materials"; Decimal)
        {
            Caption = 'Effective use of materials';
        }
        field(49; Competency; Decimal)
        {
            Caption = 'Competency (shows proper understanding of topic)';
        }
        field(50; "Communication Skills"; Decimal)
        {
        }
        field(51; "General Observations"; Text[250])
        {
        }
        field(52; "Areas of Improvement"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            TrainingSetup.Get;
            TrainingSetup.TestField("Training Nos.");
            NoSeriesMgt.InitSeries(TrainingSetup."Training Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
        Status:=Status::Open;
        if UserSetup.Get(UserId)then begin
            "Employee No":=UserSetup."Employee No.";
            Validate("Employee No");
        end;
        "Created By":=UserId;
        if EmpRec.Get("Employee No")then begin
            "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
            "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
            "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
        end;
        if NAVemp.Get("Employee No")then begin
            "Job Title":=NAVemp."Job Title";
            "Employee Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
        end;
    end;
    var UserSetup: Record "User Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    TrainingSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Training: Record "Training Nomination Header";
}
