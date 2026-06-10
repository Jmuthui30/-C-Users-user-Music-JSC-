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
                if EmpRec.Get("Employee No") then begin
                    "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee No") then begin
                    "Mobile No" := NAVemp."Mobile Phone No.";
                    "Employment Date" := NAVemp."Employment Date";
                    "Employee Name" := NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                    "Job Title" := NAVemp."Job Title";
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(9; Manager; Code[20])
        {
            trigger OnValidate()
            begin
                if NAVemp.Get("Global Dimension 3 Code") then Manager := NAVemp."First Name" + ' ' + NAVemp."Last Name";
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
        field(15; Status; Enum "Document Status")
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
                if Training.Get("Training No.") then begin
                    "Course Title" := Training."Training Title";
                    Venue := Training."Training Venue";
                    Organizers := Training.Organizers;
                    "Start Date" := Training."Start Date";
                    "End Date" := Training."End Date";
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
            OptionMembers = Yes,No;
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
            OptionMembers = "1 - No Difference","2","3","4","5-Tremendous Difference";
        }
        field(30; "Couse Content"; Option)
        {
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent,Good,"Not Good",Poor;
        }
        field(31; Notes; Option)
        {
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent,Good,"Not Good",Poor;
        }
        field(32; Presentation; Option)
        {
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent,Good,"Not Good",Poor;
        }
        field(33; "Relevance Rating"; Option)
        {
            Caption = 'Relevance';
            OptionCaption = 'Excellent,Good,Not Good,Poor';
            OptionMembers = Excellent,Good,"Not Good",Poor;
        }
        field(34; Recommend; Option)
        {
            Caption = 'Would you recommend the course for other staff ?';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
        }
        field(35; Comments; Text[250])
        {
        }
        field(36; "HR Comments"; Text[250])
        {
        }
        field(37; "Name of Facilitator"; Text[50])
        {
            Caption = 'Training Provider';
        }
        field(38; "Clear objectives"; Decimal)
        {
            Caption = 'Were the training objectives clearly explained? (1-10)';
        }
        field(39; Organization; Decimal)
        {
            Caption = 'Was the training content well organized? (1-10)';
        }
        field(40; Ease; Decimal)
        {
            Caption = 'Was the provider easy to understand? (1-10)';
        }
        field(41; Usefulness; Decimal)
        {
            Caption = 'Was the content useful and current? (1-10)';
        }
        field(42; "Meeting Objectives"; Decimal)
        {
            Caption = 'Did the training meet the course objectives? (1-10)';
        }
        field(43; "Addresses Non-compliance"; Decimal)
        {
            Caption = 'Did the provider manage time, participation, and class conduct well? (1-10)';
        }
        field(44; "Participants Engagement"; Decimal)
        {
            Caption = 'Did the provider keep participants engaged? (1-10)';
        }
        field(45; "Pratical Examples"; Decimal)
        {
            Caption = 'Did the provider use practical examples or clear explanations? (1-10)';
        }
        field(46; "Pro-social behaviour"; Decimal)
        {
            Caption = 'Did the provider create a respectful and professional learning environment? (1-10)';
        }
        field(47; "Constructive Feedback"; Decimal)
        {
            Caption = 'Did the provider respond well to questions and feedback? (1-10)';
        }
        field(48; "Use of materials"; Decimal)
        {
            Caption = 'Were the training materials used effectively? (1-10)';
        }
        field(49; Competency; Decimal)
        {
            Caption = 'Did the provider demonstrate strong knowledge of the topic? (1-10)';
        }
        field(50; "Communication Skills"; Decimal)
        {
            Caption = 'How would you rate the provider''s communication skills? (1-10)';
        }
        field(51; "General Observations"; Text[250])
        {
            Caption = 'Overall comments about the training provider';
        }
        field(52; "Areas of Improvement"; Text[250])
        {
            Caption = 'What should the training provider improve?';
        }
        field(53; "Training Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Training Request"."Request No." where(Status = const(Released));

            trigger OnValidate()
            var
                TrainingRequest: Record "Training Request";
            begin
                if "Training Request No." = '' then begin
                    "Training Need" := '';
                    exit;
                end;

                TrainingRequest.Get("Training Request No.");
                TrainingRequest.TestField("Training Need");
                Validate("Employee No", TrainingRequest."Employee No");
                "Training Need" := TrainingRequest."Training Need";
                "Course Title" := CopyStr(TrainingRequest.Description, 1, MaxStrLen("Course Title"));
                Venue := CopyStr(TrainingRequest.Venue, 1, MaxStrLen(Venue));
                "Start Date" := TrainingRequest."Planned Start Date";
                "End Date" := TrainingRequest."Planned End Date";
                Organizers := CopyStr(TrainingRequest."Training Insitution", 1, MaxStrLen(Organizers));
                SetFacilitatorFromTrainingNeed();
            end;
        }
        field(54; "Training Need"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Training Need";

            trigger OnValidate()
            begin
                SetFacilitatorFromTrainingNeed();
            end;
        }
        field(55; "Back To Office Report"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(56; "Supervisor Comments"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(57; "Supervisor Evaluated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(58; "Course Title Evaluation"; Text[2048])
        {
            Caption = 'How relevant was the course content to your role?';
            DataClassification = CustomerContent;
        }
        field(59; "Knowledge Evaluation"; Text[2048])
        {
            Caption = 'What new knowledge or skills did you gain from the training?';
            DataClassification = CustomerContent;
        }
        field(60; "Were Expectations Met"; Text[2048])
        {
            Caption = 'Were your expectations for the training met?';
            DataClassification = CustomerContent;
        }
        field(61; "Training Impact"; Text[2048])
        {
            Caption = 'How will this training improve your work performance?';
            DataClassification = CustomerContent;
        }
        field(62; "Improve Weak Areas"; Text[2048])
        {
            Caption = 'Which weak areas will you improve, and how?';
            DataClassification = CustomerContent;
        }
        field(63; "Training Techniques Satisfied"; Text[2048])
        {
            Caption = 'Were the training methods and facilitation effective?';
            DataClassification = CustomerContent;
        }
        field(64; "Food Served Satisfied"; Text[2048])
        {
            Caption = 'Were you satisfied with the meals and refreshments?';
            DataClassification = CustomerContent;
        }
        field(65; "Recommendations"; Text[2048])
        {
            Caption = 'What recommendations do you have for future trainings?';
            DataClassification = CustomerContent;
        }
        field(66; "No Answer Explanation"; Text[2048])
        {
            Caption = 'If any answer was No or Unsatisfactory, please explain.';
            DataClassification = CustomerContent;
        }
        field(67; "Personal Action Plans"; Text[2048])
        {
            Caption = 'What personal action plans will you implement after this training?';
            DataClassification = CustomerContent;
        }
        field(68; "Action Plan Barriers"; Text[2048])
        {
            Caption = 'What barriers may affect your action plans, and how will you address them?';
            DataClassification = CustomerContent;
        }
        field(69; "How To Overcome Assignments"; Text[2048])
        {
            Caption = 'How will you overcome assignment or workload challenges?';
            DataClassification = CustomerContent;
        }
        field(70; "Resource Requirements"; Text[2048])
        {
            Caption = 'What resources do you need to implement your action plans?';
            DataClassification = CustomerContent;
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
            // NoSeriesMgt.InitSeries(TrainingSetup."Training Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            if NoSeriesMgt.AreRelated(TrainingSetup."Training Nos.",xRec."No. Series") then
            "No. Series":=xRec."No. Series"
            else
            "No. Series":=TrainingSetup."Training Nos.";
            "No.":=NoSeriesMgt.GetNextNo("No. Series",WorkDate());
        end;
        Date := Today;
        Status := Status::Open;
        if UserSetup.Get(UserId) then begin
            "Employee No" := UserSetup."Employee No.";
            Validate("Employee No");
        end;
        "Created By" := UserId;
        if EmpRec.Get("Employee No") then begin
            "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
            "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
            "Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
        end;
        if NAVemp.Get("Employee No") then begin
            "Job Title" := NAVemp."Job Title";
            "Employee Name" := NAVemp."First Name" + ' ' + NAVemp."Last Name";
        end;
    end;

    trigger OnModify()
    begin
        EnsureTrainingRequestLinked();
    end;

    var
        UserSetup: Record "User Setup";
        Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
        NAVemp: Record Employee;
        EmpRec: Record "Employee Master";
        TrainingSetup: Record "QuantumJumps HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Training: Record "Training Nomination Header";

    local procedure EnsureTrainingRequestLinked()
    begin
        TestField("Training Request No.");
        TestField("Training Need");
    end;

    local procedure SetFacilitatorFromTrainingNeed()
    var
        TrainingNeed: Record "Training Need";
        Vendor: Record Vendor;
    begin
        if "Training Need" = '' then
            exit;

        if not TrainingNeed.Get("Training Need") then
            exit;

        if TrainingNeed."Provider Name" <> '' then
            "Name of Facilitator" := CopyStr(TrainingNeed."Provider Name", 1, MaxStrLen("Name of Facilitator"))
        else
            if Vendor.Get(TrainingNeed.Provider) then
                "Name of Facilitator" := CopyStr(Vendor.Name, 1, MaxStrLen("Name of Facilitator"));
    end;
}
