tableextension 51424 "ExtEmployee" extends "Employee"
{
    fields
    {
        field(51600; "Position To Succeed"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(51601; "Recruitment Need"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs";
            Editable = false;

            trigger OnValidate()
            begin
                If RecruitmentNeed.Get("Recruitment Need") then begin
                    "Job Id" := RecruitmentNeed."Job ID";
                    "Job Title" := RecruitmentNeed.Description;
                    //Job_Title := RecruitmentNeed.Description;
                    "Job Description" := RecruitmentNeed.Objective;
                end;
            end;
        }
        field(51602; "Job Id"; Code[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Recruitment Needs";
            TableRelation = "Company Jobs";
            Editable = true;

            trigger OnValidate()
            var
                CompanyJobs: Record "Company Jobs";
            begin
                CompanyJobs.Reset();
                CompanyJobs.SetRange("Job ID", "Job Id");
                if CompanyJobs.FindFirst() then "Job Title" := CompanyJobs.Name;
            end;
        }
        /* field(51603; "Job_Title"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Job Title';
        } */
        field(51604; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51605; "Application Submited"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51500; "Job Mobility"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ","Yes","No";
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(51501; "Job Mobility Preference"; Option)
        {
            OptionCaption = ' ,Short-term assignment (<12 months),Medium-term assignment (12 - 24 months),Permanent Transfer';
            OptionMembers = " ","Short-term assignment (<12 months)","Medium-term assignment (12 - 24 months)","Permanent Transfer";
            DataClassification = ToBeClassified;
        }
        field(51502; "Other Mobility Considerations"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51503; "Career Plan Submitted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51504; "Career Plan Reviewer"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51505; "Career Plan Approved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51606; "Employee Age"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51607; "Is Board"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // field(51608; "Employee Type"; Option)
        // {
        //     OptionCaption = 'Primary Employee,Secondary Employee';
        //     OptionMembers = "Primary Employee", "Secondary Employee";
        // }
        field(51609; "Residential Status"; Option)
        {
            OptionCaption = 'Resident,Foreign';
            OptionMembers = "Resident","Foreign";
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            begin
                ValidateEmployeeAge;
                "Employee Age" := HRDatesExt.DetermineDatesDiffrence("Birth Date", Today);
            end;
        }
        field(51610; "Has Special Needs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51611; "Disability Description"; Text[2000])
        {
            Caption = 'Description';
        }

        modify("Social Security No.")
        {
            Caption = 'NSSF No.';
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                if Status = Status::Inactive then
                    Message('Kindly specify Cause For Inactivity');
            end;
        }
        field(52001; "Nature of Employment"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract".Code;
            Caption = 'Nature of Employment';

            trigger OnValidate()
            begin
                //if EmpContract.Get("Nature of Employment") then
                //    "Employee Type" := EmpContract."Employee Type"
            end;
        }
        field(52002; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';

            trigger OnValidate()
            begin

                ContractPeriod := CalcDate("Contract Length", "Contract Start Date") - 1;
                "Contract End Date" := ContractPeriod;
            end;
        }
        field(52003; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
            Caption = 'Contract End Date';
        }
        field(52004; "Employment Date - Age"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Employment Date - Age';
        }
        field(52005; "First Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'First Language';
        }
        field(52006; "Second Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language';
        }
        field(52007; "First Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Read';
        }
        field(52008; "First Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Write';
        }
        field(52009; "First Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Speak';
        }
        field(52010; "Second Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Read';
        }
        field(52011; "Second Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Write';
        }
        field(52012; "Second Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Speak';
        }
        field(52013; "Other Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language';
        }

        field(52015; "Job Position Title"; Text[250])
        {
            Caption = 'Job Position Title';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = filter("Job Application Status"::Application)));
        }
        field(52016; "Leave Period Filter"; Code[20])
        {
            TableRelation = "Leave Period"."Leave Period Code";
            Caption = 'Leave Period Filter';
            FieldClass = FlowFilter;
        }
        field(52017; "Leave Type Filter"; Code[20])
        {
            Caption = 'Leave Type Filter';
            TableRelation = "Leave Type".Code;
            FieldClass = FlowFilter;
        }
        field(52018; Signature; MediaSet)
        {
            DataClassification = CustomerContent;
            Caption = 'Signature';
        }
        field(52019; Disabled; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;
            Caption = 'Disabled';
        }
        field(52021; "Pays NSSF?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pays NSSF?';
        }
        field(52022; "Pays tax?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pays tax?';
        }
        field(52024; "Employee Nature"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Nature';
        }

        field(52029; "Employee's Bank"; Code[80])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
            Caption = 'Employee''s Bank';

            trigger OnValidate()
            begin
                if Banks.Get("Employee's Bank") then
                    "Employee Bank Name" := Banks.Name;
            end;
        }
        field(52030; "Bank Branch"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("Employee's Bank"));
            Caption = 'Bank Branch';

            trigger OnValidate()
            begin
                if Branches.Get("Employee's Bank", "Bank Branch") then
                    "Employee Branch Name" := Branches."Branch Name";

                "Employee Bank Sort Code" := "Employee's Bank" + "Bank Branch";
            end;
        }
        field(52031; "Bank Account Number"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account Number';

            trigger OnValidate()
            begin
                if (strlen("Bank Account Number") < 8) or (strlen("Bank Account Number") > 13) then
                    Error('Bank Account Number can not be less than 8 and more than 13 characters');
            end;
        }
        field(52032; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            // TableRelation = "Employee HR Posting Group";
            Caption = 'Posting Group';

            trigger OnValidate()
            begin
                /*
                if xRec."Posting Group"='PROBATION' then
                begin
                
                 if "Date Of Join"<>0D then
                 begin
                   NoofMonthsWorked:=0;
                   Nextmonth:="Date Of Join";
                   repeat
                      Nextmonth:=CalcDate('1M',Nextmonth);
                      NoofMonthsWorked:=NoofMonthsWorked+1;
                   until NoofMonthsWorked=HumanResSetup."Probation Period(Months)";
                      EndDate:=Nextmonth;
                 end;
                 if EndDate>Today then
                   Error('You cannot change status from Probation before the probation period has expired');
                end;
                */

            end;
        }
        field(52033; "Salary Scale"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Scale".Scale;
            Caption = 'Salary Grade';

            trigger OnValidate()
            begin
                TestField("Date Of Join");

                if Scale.Get("Salary Scale") then
                    Halt := Scale."Maximum Pointer";

                "Previous Salary Scale" := xrec."Salary Scale";
            end;
        }
        field(52051; "ID No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ID No.';
            trigger OnValidate()
            begin
                if (strlen("ID No.") < 7) or (strlen("ID No.") > 10) then
                    Error('ID Number can not be less than 7 and more than 10 characters');
            end;
        }
        field(52052; Position; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Position';

            trigger OnValidate()
            begin

                if Jobs.Get(Position) then
                    "Job Title" := Jobs."Job Description";

                if ((xRec.Position <> '') and (Position <> xRec.Position)) then begin
                    Jobs.Reset();
                    Jobs.SetRange(Jobs."Job ID", Position);
                    if Jobs.Find('-') then
                        "Job Title" := Jobs."Job Description";
                    /*Payroll.Copy(Rec);
                    Payroll.Reset();
                    Payroll.SetRange(Payroll."No.","No.");
                    if Payroll.Find('-') then begin
                        Payroll."Salary Scheme Category":=Jobs.Category;
                        Payroll."Salary Steps":=Jobs.Grade;
                      //  Payroll.VALIDATE(Payroll."Salary Steps");
                        Payroll.Modify();
                    end;*/
                    //"Salary Scheme Category":=Jobs.Category;
                    //"Salary Steps":=Jobs.Grade;
                    //MODIFY;
                end;

            end;
        }
        field(52053; "Full / Part Time"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Full Time, Part Time';
            OptionMembers = "Full Time"," Part Time";
            Caption = 'Full / Part Time';
        }
        field(52054; "Contract Type"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract".Code;
            Caption = 'Contract Type';

            trigger OnValidate()
            begin
                /*
                if "Contract Type"="Contract Type"::"Long-Term" then
                  "Contract Length"> '6M' else
                  Error('The Period is too short for the Contract Type');
                
                if "Contract Type"="Contract Type"::"Short-Term" then
                  "Contract Length"<'7M' else
                  Error('The Period is Longer than the Contract Type');
                */

            end;
        }
        field(52055; "Type of Contract"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract";
            Caption = 'Type of Contract';

            trigger OnValidate()
            begin

                // if EmpContract.Get("Type of Contract") then
                // "Contract Length" := EmpContract.Code;
            end;
        }
        field(52056; "Notice Period"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Notice Period';
        }
        field(52057; "Marital Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Caption = 'Marital Status';
        }
        field(52058; "Ethnic Origin"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'African,Indian,White,Coloured';
            OptionMembers = African,Indian,White,Coloured;
            Caption = 'Ethnic Origin';
        }
        field(52059; "First Language (R/W/S)"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
            Caption = 'First Language (R/W/S)';
        }
        field(52060; "Driving Licence"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driving Licence';
        }
        field(52062; "Date Of Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Join';

            trigger OnValidate()
            var
                CurrentYear: Integer;
                JoinMonth: Integer;
            begin
                JoinMonth := 0;
                CurrentYear := 0;

                if "Date Of Join" <> 0D then begin
                    if "Date Of Join" > Today then
                        Error('Date of join can not be in the future');

                    if "End Of Probation Date" = 0D then begin
                        HumanResSetup.Get();
                        HumanResSetup.TestField("Probation Period");
                        "End Of Probation Date" := CalcDate(HumanResSetup."Probation Period", "Date Of Join") - 1;
                    end;

                    // "Employment Date - Age" := HRDates.DetermineAge("Date Of Join", Today);

                    if "Incremental Month" = '' then begin
                        JoinMonth := Date2DMY("Date Of Join", 2);
                        Evaluate("Incremental Month", Format(JoinMonth));
                    end;

                    CurrentYear := Date2DMY(Today(), 3);

                    //Check employee who joins in current year - push increment to next year
                    // if "Next Increment Date" = 0D then
                    //     if Date2DMY("Date Of Join", 3) = CurrentYear then
                    //         "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), CurrentYear + 1)
                    //     else
                    //         //Else increment to this year
                    //         //if not Payroll.CheckIfIncrementEffectedInCurrentYear(Rec, CurrentYear) then
                    //             "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), CurrentYear)
                    // else
                    // "Next Increment Date" := DMY2Date(1, Date2DMY("Date Of Join", 2), (CurrentYear + 1));
                end;
                /*
                DateInt:=Date2DMY("Date Of Join",1);
                "Pro-Rata on Joining":=HumanResSetup."No. Of Days in Month"-DateInt+1;
                PayPeriod.Reset();
                PayPeriod.SetRange(PayPeriod."Starting Date",0D,"Date Of Join");
                PayPeriod.SetRange(PayPeriod."New Fiscal Year",true);
                if PayPeriod.Find('+') then
                begin
                FiscalStart:=PayPeriod."Starting Date";
                MaturityDate:=CalcDate('1Y',PayPeriod."Starting Date")-1;
                 Message('Maturity %1',MaturityDate)
                end;
                
                if ("Posting Group"='PERMANENT') or ("Posting Group"='DG') then begin
                //MESSAGE('Date of join %1',"Date Of Join") ;
                 Entitlement:=Round(((MaturityDate-"Date Of Join")/30),1)*2.5;
                
                EmpLeaves.Reset();
                EmpLeaves.SetRange(EmpLeaves."Employee No","No.");
                EmpLeaves.SetRange(EmpLeaves."Maturity Date",MaturityDate);
                if not EmpLeaves.Find('-') then begin
                  EmpLeaves."Employee No":="No.";
                  EmpLeaves."Leave Code":='ANNUAL';
                  EmpLeaves."Maturity Date":=MaturityDate;
                  EmpLeaves.Entitlement:=Entitlement;
                //IF NOT EmpLeaves.GET("No.",'ANNUAL',MaturityDate) THEN
                  EmpLeaves.Insert();
                end;
                
                end;
                  */

            end;
        }
        field(52063; "End Of Probation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Of Probation Date';
        }
        field(52064; "Pension Scheme Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pension Scheme Join';

            trigger OnValidate()
            begin
                /*  if ("Date Of Leaving" <> 0D) and ("Pension Scheme Join" <> 0D) then
                   "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");

            */

            end;
        }
        field(52065; "Medical Scheme Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Medical Scheme Join';

            trigger OnValidate()
            begin
                /*  if  ("Date Of Leaving" <> 0D) and ("Medical Scheme Join" <> 0D) then
                   "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
                */

            end;
        }
        field(52066; "Date Of Leaving"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Leaving';

            trigger OnValidate()
            begin
                /* if ("Date Of Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
                 if ("Pension Scheme Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
                 if ("Medical Scheme Join" <> 0D) and ("Date Of Leaving" <> 0D) then
                  "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");


                 if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin
                    ExitInterviews.SetRange("Employee No.","No.");
                    OK:= ExitInterviews.Find('-');
                    if OK then begin
                      ExitInterviews."Date Of Leaving":= "Date Of Leaving";
                      ExitInterviews.Modify();
                    end;
                    Commit();
                 end;


                if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin
                   CareerEvent.SetMessage('Left The Company');
                   CareerEvent.RunModal();
                   OK:= CareerEvent.ReturnResult;
                    if OK then begin
                       CareerHistory.Init();
                       if not CareerHistory.Find('-') then
                        CareerHistory."Line No.":=1
                      else begin
                        CareerHistory.Find('+');
                        CareerHistory."Line No.":=CareerHistory."Line No."+1;
                      end;

                       CareerHistory."Employee No.":= "No.";
                       CareerHistory."Date Of Event":= "Date Of Leaving";
                       CareerHistory."Career Event":= 'Left The Company';
                       CareerHistory."Employee First Name":= "Known As";
                       CareerHistory."Employee Last Name":= "Last Name";

                       CareerHistory.Insert();
                    end;
                end;
               */
                /*
                ExitInterviewTemplate.Reset();
                //TrainingEvalTemplate.SETRANGE(TrainingEvalTemplate."AIT/Evaluation",TrainingEvalTemplate."AIT/Evaluation"::AIT);
                if ExitInterviewTemplate.Find('-') then
                repeat
                ExitInterviewLines.Init();
                ExitInterviewLines."Employee No":="No.";
                ExitInterviewLines.Question:=ExitInterviewTemplate.Question;
                ExitInterviewLines."Line No":=ExitInterviewTemplate."Line No";
                ExitInterviewLines.Bold:=ExitInterviewTemplate.Bold;
                ExitInterviewLines."Answer Type":=ExitInterviewTemplate."Answer Type";
                if not ExitInterviewLines.Get(ExitInterviewLines."Line No",ExitInterviewLines."Employee No") then
                ExitInterviewLines.Insert()
                
                
                until ExitInterviewTemplate.Next()=0;
                */

            end;
        }
        field(52067; "Second Language (R/W/S)"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
            Caption = 'Second Language (R/W/S)';
        }
        field(52068; "Additional Language"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
            Caption = 'Additional Language';
        }
        field(52069; "Termination Category"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Resignation,Non-Renewal Of Contract,Dismissal,Retirement,Death,Other';
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;
            Caption = 'Termination Category';

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                if "Resource No." <> '' then begin
                    OK := "Lrec Resource".Get("Resource No.");
                    "Lrec Resource".Blocked := true;
                    "Lrec Resource".Modify();
                end;
            end;
        }
        field(52070; "Passport Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Passport Number';
        }
        field(52071; "HELB No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'HELB No';
        }
        field(52072; "Co-Operative No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Co-Operative No';
        }
        field(52073; "Succesion Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Succesion Date';
        }
        field(52074; "Send Alert to"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Send Alert to';
        }
        field(52075; Religion; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Religion';
        }
        field(52076; "Served Notice Period"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Served Notice Period';
        }
        field(52077; "Exit Interview Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Interview Date';
        }
        field(52078; "Exit Interview Done by"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";
            Caption = 'Exit Interview Done by';
        }
        field(52079; "Allow Re-Employment In Future"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Re-Employment In Future';
        }
        field(52080; "Incremental Month"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Anniversary Month';
        }
        field(52081; "Present Pointer"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Salary Scale"));
            Caption = 'Present Step';

            trigger OnValidate()
            begin
                TestField("Date Of Join");

                // Payroll.DefaultEarningsDeductionsAssignment(Rec);
                Previous := xRec."Present Pointer";
            end;
        }
        field(52082; Previous; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field("Previous Salary Scale"));
            Caption = 'Previous Step';
        }
        field(52083; Halt; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Pointer";
            Caption = 'Halt';
        }
        field(52088; "Other Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language Read';
        }
        field(52089; "Other Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language Write';
        }
        field(52090; "Other Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language Speak';
        }
        field(52091; "Employee Job Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = '  ,Driver,Executive,Director';
            OptionMembers = "  ",Driver,Executive,Director;
            Caption = 'Employee Job Type';
        }
        field(52092; "Contract Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Number';
        }
        field(52094; "Blood Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Blood Type';
        }
        field(52095; Disability; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability';
        }
        field(52096; "County Code"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County Code';
        }
        field(52097; "Retirement Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Retirement Date';
        }
        field(52098; "Medical Member No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Medical Member No';
        }
        field(52099; "Exit Ref No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Ref No';
        }
        field(52101; Company; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Company;
            Caption = 'Company';
        }
        field(52102; "Min Tax Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Min Tax Rate';
        }
        field(52103; "Acting Position"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Acting Position';
        }
        field(52104; "Acting No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Acting No';
        }
        field(52105; "Acting Description"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Acting Description';
        }
        field(52106; "Relieved Employee"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Relieved Employee';
        }
        field(52107; "Relieved Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Relieved Name';
        }
        field(52108; "Reason for Acting"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason for Acting';
        }
        field(52109; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(52110; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(52111; "Disability Certificate"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability Certificate';
        }
        field(52112; Name; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(52114; "Contract Length"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Length';

            trigger OnValidate()
            begin
                Validate("Contract Start Date");
                /*
                if "Contract Type"="Contract Type"::"Long-Term" then
                  "Contract Length">'<6M>' else
                  Error('The Contract Period Should be Greater than 6 Months');
                */

            end;
        }
        field(52115; "Payroll Suspenstion Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Suspenstion Date';
        }
        field(52116; "Payroll Reactivation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Reactivation Date';
        }
        field(52117; "Employee Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Board Member,Attachee,Intern';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,"Board Member",Attachee,Intern;
            Caption = 'Employee Type';
        }
        field(52120; "Employment Type"; Enum "Employment Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Employment Type';
        }
        field(52121; "Area"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Area';
        }
        field(52123; "Ethnic Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Ethnic Name';
        }
        field(52124; "Home District"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Home District';
        }
        field(52125; "Employee Bank Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Bank Name';
        }
        field(52126; "Employee Bank Sort Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Bank Sort Code';
        }
        field(52127; "Employee Branch Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Branch Name';
        }
        field(52128; "Insurance Relief"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Relief';
        }
        field(52131; "Debtor Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Caption = 'Debtor Code';
        }
        field(52132; "Current Leave Period"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Leave Period"."Leave Period Code" where(Closed = const(true)));
            Caption = 'Current Leave Period';
            Editable = false;
        }
        field(52133; "Secondary Employee"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Employee';
        }
        field(52135; "Leave Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Description = 'With Flowfilters';
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("No."),
                                                                            "Leave Period Code" = field("Leave Period Filter"),
                                                                            "Leave Type" = field("Leave Type Filter")));
            Caption = 'Leave Balance';
        }
        field(52136; "Gratuity Vendor No."; code[50])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
            Caption = 'Gratuity Vendor No.';
        }
        field(52137; "Secondary Job Position"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Secondary Job Position';

            trigger OnValidate()
            begin

                if Jobs.Get("Secondary Job Position") then
                    "Secondary Job Position Title" := Jobs."Job Description";
            end;
        }
        field(52138; "Secondary Job Position Title"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Job Position Title';
            Editable = false;
        }
        field(52139; "Leave Days Taken"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Description = 'With Flowfilters';
            CalcFormula = - sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("No."),
                                                                            "Leave Period Code" = field("Leave Period Filter"),
                                                                            "Leave Type" = field("Leave Type Filter"),
                                                                            "Leave Entry Type" = const(Negative)));
            Caption = 'Leave Days Taken';
        }
        field(52140; "Manager/Supervisor"; Code[20])
        {
            TableRelation = Employee."No." where(Status = const(Active));
            Caption = 'Manager/Supervisor';
            DataClassification = CustomerContent;
        }
        field(52141; "Previous Salary Scale"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salary Scale".Scale;
            Caption = 'Previous Salary Grade';
        }
        field(52020; "Other Name"; Text[150])
        {
            Caption = 'Other Name';
            DataClassification = CustomerContent;
        }
        field(52061; "Leave Entitlement"; Decimal)
        {
            //CalcFormula = lookup("Leave Type".Days where(Code = field("Leave Type Filter")));
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("No."),
                                                                            "Transaction Type" = filter("Leave Allocation"),
                                                                            "Leave Type" = field("Leave Type Filter"),
                                                                            "Leave Period Code" = field("Leave Period Filter")));
            Caption = 'Leave Entitlement';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52142; "Leave Balance Brought Forward"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("No."),
                                                                                         "Transaction Type" = filter("Leave B/F"),
                                                                                         "Leave Type" = field("Leave Type Filter"),
                                                                                         "Leave Period Code" = field("Leave Period Filter")));
            FieldClass = FlowField;
            Caption = 'Leave Balance Brought Forward';
            Editable = false;
        }
        field(52143; "Leave Recall Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("No."),
                                                                                         "Transaction Type" = filter("Leave Recall"),
                                                                                         "Leave Type" = field("Leave Type Filter"),
                                                                                         "Leave Period Code" = field("Leave Period Filter")));
            FieldClass = FlowField;
            Caption = 'Leave Recall Days';
            Editable = false;
        }
        field(52150; "Last Date Increment"; Date)
        {
            CalcFormula = max("Salary Pointer Increment"."Increment Date" where("Employee No." = field("No.")));
            Caption = 'Last Date Increment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52151; "Next Date Increment"; Date)
        {
            CalcFormula = max("Salary Pointer Increment"."Next Increment Date" where("Employee No." = field("No.")));
            Caption = 'Next Date Increment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52152; "Leave Adjustment"; Decimal)
        {
            //CalcFormula = lookup("Leave Type".Days where(Code = field("Leave Type Filter")));
            CalcFormula = sum("HR Leave Ledger Entries"."No. of days" where("Staff No." = field("No."),
                                                                            "Transaction Type" = filter("Leave Adjustment"),
                                                                            "Leave Type" = field("Leave Type Filter"),
                                                                            "Leave Period Code" = field("Leave Period Filter")));
            Caption = 'Leave Adjustment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52153; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
        }
        field(52154; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(52155; "Employee Category"; Code[20])
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            TableRelation = "Employee Category".Code;
        }
        field(52156; "Base Calendar"; Code[10])
        {
            Caption = 'Base Calendar';
            DataClassification = CustomerContent;
            TableRelation = "Base Calendar".Code;
        }
        field(52157; "Exempt from third rule"; Boolean)
        {
            Caption = 'Exempt from third rule';
        }
        field(52160; "Contract Extension"; Boolean)
        {
            Caption = 'Contract Extension';
        }
        field(52161; "Contract Renewal Date"; Date)
        {
            Caption = 'Contract Renewal Date';
        }
        field(52162; "Contract Renewal Period"; DateFormula)
        {
            Caption = 'Contract Renewal Period';
        }
        field(52163; "SHIF No."; Code[20])
        {
            Caption = 'SHIF No.';
        }
        field(52165; "Personal Email"; Code[80])
        {
            Caption = 'Personal Email';
        }
        field(52166; "Line Manager"; Code[20])
        {
            TableRelation = Employee."No." where(Status = const(Active));
            Caption = 'Line Manager';
            DataClassification = CustomerContent;
        }
        field(52167; "Approval Status"; Enum "Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
        }
        field(52168; "Home County"; Option)
        {
            OptionMembers = " ",Mombasa,Kwale,Kilifi,"Tana River",Lamu,"Taita-Taveta",Garissa,Wajir,Mandera,Marsabit,Isiolo,Meru,"Tharaka-Nithi",Embu,Kitui,Machakos,Makueni,Nyandarua,Nyeri,Kirinyaga,"Murang’a",Kiambu,Turkana,"West Pokot",Samburu,"Trans-Nzoia","Uasin Gishu","Elgeyo-Marakwet",Nandi,Baringo,Laikipia,Nakuru,Narok,Kajiado,Kericho,Bomet,Kakamega,Vihiga,Bungoma,Busia,Siaya,Kisumu,"Homa Bay",Migori,Kisii,Nyamira,Nairobi;
            Caption = 'Home County';
        }
        field(52169; "Imprest Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Caption = 'Imprest Account';
        }
        field(52170; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'User ID';

            trigger OnValidate()
            var
                UserIDExistsErr: Label 'Employee with User ID %1 already exists';
            begin
                if "User ID" <> '' then begin
                    EmployeeRec.Reset();
                    EmployeeRec.SetRange("User ID", "User ID");
                    if EmployeeRec.FindFirst() then
                        Error(UserIDExistsErr, "User ID");
                end;
            end;
        }
    }

    trigger OnInsert()
    begin
        if "Employee Type" = "Employee Type"::"Board Member" then begin
            HumanResSetup.Get();
            // HumanResSetup.TestField("Trustee Nos");
        end;
    end;

    var
        EmployeeRec: Record Employee;
        RecruitmentNeed: Record "Recruitment Needs";
        HRDatesExt: Codeunit "HR Dates Mgt";
        Branches: Record "Bank Branches";
        Banks: Record "Bank Account";
        Jobs: Record "Company Job";
        EmpContract: Record "Employment Contract";
        // Ethnic: Record "Ethnic Communities";
        HumanResSetup: Record "Human Resources Setup";
        PayPeriod: Record "Payroll Period";
        Scale: Record "Salary Scale";
        //HRDates: Codeunit "Dates Management";
        // Payroll: Codeunit Payroll;
        dateform: DateFormula;
        Begindate: Date;
        ContractPeriod: Date;

    local procedure ValidateEmployeeAge()
    begin
        if "Birth Date" <> 0D then if ((Date2DMY(WorkDate, 3) - Date2DMY("Birth Date", 3)) < 18) then Error('The Employee Must be above 18 years. Kindly Confirm the Birthdate');
    end;

    procedure GetPayPeriod()
    begin

        PayPeriod.Reset();
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then
            //PayPeriodtext:=PayPeriod.Name;
            Begindate := PayPeriod."Starting Date";
        //MESSAGE('%1',Begindate);
    end;

    procedure EnforcePayrollPermissions() PageEditable: Boolean
    var
        UserSetup: Record "User Setup";
        NotAllowedToAccessEmployeesErr: Label 'You are not allowed to access employee information. Kindly contact your system administrator.';
        NotSetupAsUserErr: Label 'You are not set up as a user on User Setup. Kindly contact your system administrator.';
    begin
        if UserSetup.Get(UserId()) then begin
            if "Employee Type" <> "Employee Type"::"Board Member" then begin
                PageEditable := false;

                // if not UserSetup."View HR Information" then
                //  Error(NotAllowedToAccessEmployeesErr);

                //if UserSetup."Edit HR Information" then
                //   PageEditable := true
                // else
                PageEditable := false;
            end else
                PageEditable := true;
        end else
            Error(NotSetupAsUserErr);
    end;
}
