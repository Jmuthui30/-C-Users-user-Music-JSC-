page 52467 "Employee Change Card"
{
    ApplicationArea = All;
    Caption = 'Employee Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Effect Changes';
    SourceTable = "Employee Change Request";

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.';
                }
                field("No."; Rec."No.")
                {
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    // Visible = NoFieldVisible;
                    //Editable = false;

                    trigger OnAssistEdit()
                    begin
                        //AssistEdit;
                    end;
                }
                //fullname
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Standard;
                    ToolTip = 'Specifies the employee''s full name.';
                    editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the value of the Initials field';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
                    Visible = false;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ToolTip = 'Specifies the value of the Passport No. field';
                    Visible = false;
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Driving Licence field';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field';
                    Editable = false;
                }


                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field';

                    trigger OnValidate()
                    begin

                        if Rec.Disabled = Rec.Disabled::No then
                            DisabilityView := false
                        else
                            DisabilityView := true;
                    end;
                }
                group(Control129)
                {
                    ShowCaption = false;
                    Visible = DisabilityView;

                    field("Disability Certificate"; Rec."Disability Certificate")
                    {
                        Caption = 'Disability Certificate No.';
                        ToolTip = 'Specifies the value of the Disability Certificate No. field';
                    }
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Visible = false;
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Birth';
                    Importance = Standard;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Date of Birth - Age"; Rec."Date of Birth - Age")
                {
                    Editable = false;
                    Caption = ' Age';
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the  Age field';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field';
                }
                field(Religion; Rec.Religion)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Religion field';
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ethnic Origin field';
                }
                // field("Ethnic Community"; Rec."Ethnic Community")
                // {
                //     Caption = 'Ethnic Code';
                //     Visible = false;
                //     ToolTip = 'Specifies the value of the Ethnic Code field';
                // }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    Visible = false;
                    Caption = 'Ethnic Community';
                    ToolTip = 'Specifies the value of the Ethnic Community field';
                }
                field("Home District"; Rec."Home District")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Home District field';
                }
                field(County; Rec.County)
                {
                    Caption = 'Home District';
                    ToolTip = 'Specifies the value of the Home District field';
                }
                field("First Language"; Rec."First Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the First Language field';
                }
                field("Second Language"; Rec."Second Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Second Language field';
                }
                field("Other Language"; Rec."Other Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Other Language field';
                }
            }
            group("Employment Information")
            {
                Caption = 'Employment Information';
                Visible = false;
                field("Employee Company"; Rec."Employee Company")
                {
                    Caption = 'Company';
                    ToolTip = 'Specifies the value of the Company field';
                }
                field("Job Position"; Rec."Job Position")
                {
                    ToolTip = 'Specifies the value of the Job Position field';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the value of the Area field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';
                    ToolTip = 'Specifies the value of the Employment Type field';

                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                field("Clearance Department"; Rec."Clearance Department")
                {
                    ToolTip = 'Specifies the value of the Clearance Department field';
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = false;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                        ToolTip = 'Specifies the value of the Contract Type field';
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                        ToolTip = 'Specifies the value of the Contract Number field';
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                        ToolTip = 'Specifies the value of the Contract Length field';
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                        ToolTip = 'Specifies the value of the Contract Start Date field';
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                        ToolTip = 'Specifies the value of the Contract End Date field';
                    }
                }
            }
            group("Acting Position")
            {
                Caption = 'Acting Position';
                Visible = false;

                field("Acting No"; Rec."Acting No")
                {
                    ToolTip = 'Specifies the value of the Acting No field';
                }
                field(Control159; Rec."Acting Position")
                {
                    ToolTip = 'Specifies the value of the Acting Position field';
                }
                field("Acting Description"; Rec."Acting Description")
                {
                    ToolTip = 'Specifies the value of the Acting Description field';
                }
                label("Details:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Relieved Employee"; Rec."Relieved Employee")
                {
                    ToolTip = 'Specifies the value of the Relieved Employee field';
                }
                field("Relieved Name"; Rec."Relieved Name")
                {
                    ToolTip = 'Specifies the value of the Relieved Name field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Reason for Acting"; Rec."Reason for Acting")
                {
                    ToolTip = 'Specifies the value of the Reason for Acting field';
                }
            }
            group(Administration)
            {
                Visible = false;
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ToolTip = 'Specifies the value of the Inactive Date field';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ToolTip = 'Specifies the value of the Cause of Inactivity Code field';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ToolTip = 'Specifies the value of the Termination Date field';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ToolTip = 'Specifies the value of the Grounds for Term. Code field';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ToolTip = 'Specifies the value of the Statistics Group Code field';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resource No. field';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field';
                }
            }
            group("Lecturer Info")
            {
                Visible = false;
                Caption = 'Lecturer Info';

                field("Is Lecturer"; Rec."Is Lecturer")
                {
                    ToolTip = 'Specifies the value of the Is Lecturer field';
                }
                field("Lecturer Type"; Rec."Lecturer Type")
                {
                    ToolTip = 'Specifies the value of the Lecturer Type field';
                }
                field("Lecturer Password"; Rec."Lecturer Password")
                {
                    ToolTip = 'Specifies the value of the Lecturer Password field';
                }
                field("Portal Registered"; Rec."Portal Registered")
                {
                    ToolTip = 'Specifies the value of the Portal Registered field';
                }
                field("Activation Code"; Rec."Activation Code")
                {
                    ToolTip = 'Specifies the value of the Activation Code field';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                Editable = true;
                Visible = false;

                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Employee Posting Group field';
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the PIN Number field';
                }
                field("NHIF No."; Rec."NHIF No")
                {
                    Caption = 'NHIF No.';
                    ToolTip = 'Specifies the value of the NHIF No. field';
                }
                field("NSSF No."; Rec."Social Security No.")
                {
                    ToolTip = 'Specifies the value of the Social Security No. field';
                }
                field("HELB No"; Rec."HELB No")
                {
                    ToolTip = 'Specifies the value of the HELB No field';
                }
                field("Co-Operative No"; Rec."Co-Operative No")
                {
                    ToolTip = 'Specifies the value of the Co-Operative No field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field("Employee's Bank"; Rec."Employee's Bank")
                {
                    Caption = 'Bank';
                    ToolTip = 'Specifies the value of the Bank field';

                    trigger OnValidate()
                    begin

                        if Banks.Get(Rec."Bank Code") then
                            BankName := Banks.Name;
                    end;
                }
                field("Employee Bank Name"; Rec."Employee Bank Name")
                {
                    Caption = 'Bank Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field';
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    Caption = 'Branch';
                    ToolTip = 'Specifies the value of the Branch field';
                }
                field("Employee Branch Name"; Rec."Employee Branch Name")
                {
                    Caption = 'Branch Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Branch Name field';
                }
                field("Employee Bank Sort Code"; Rec."Employee Bank Sort Code")
                {
                    Caption = 'Sort Code';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sort Code field';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ToolTip = 'Specifies the value of the Bank Account Number field';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'HR Posting Group';
                    ToolTip = 'Specifies the value of the HR Posting Group field';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field';
                }
                field("Salary Scale"; Rec."Salary Scale")
                {
                    ToolTip = 'Specifies the value of the Salary Scale field';
                }
                field(Present; Rec.Present)
                {
                    Caption = 'Present Pointer';
                    ToolTip = 'Specifies the value of the Present Pointer field';
                }
                field(Previous; Rec.Previous)
                {
                    Caption = 'Previous Pointer';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Previous Pointer field';
                }
                field(Halt; Rec.Halt)
                {
                    Caption = 'Halt Pointer';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Halt Pointer field';
                }
                field("Incremental Month"; Rec."Incremental Month")
                {
                    ToolTip = 'Specifies the value of the Incremental Month field';
                }
                field("Pays tax?"; Rec."Pays tax?")
                {
                    ToolTip = 'Specifies the value of the Pays tax? field';
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Relief field';
                }
                field("Pro-Rata Calculated"; Rec."Pro-Rata Calculated")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pro-Rata Calculated field';
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the House Allowance field';
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Insurance Premium field';
                }
                field("Total Allowances"; Rec."Total Allowances")
                {
                    ToolTip = 'Specifies the value of the Total Allowances field';
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ToolTip = 'Specifies the value of the Total Deductions field';
                }
                field("Taxable Allowance"; Rec."Taxable Allowance")
                {
                    ToolTip = 'Specifies the value of the Taxable Allowance field';
                }
                field("Cumm. PAYE"; Rec."Cumm. PAYE")
                {
                    ToolTip = 'Specifies the value of the Cumm. PAYE field';
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                Visible = false;
                field("Date Of Join"; Rec."Date Of Join")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Of Join field';

                    trigger OnValidate()
                    begin

                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the ProbationPeriod field';
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Probation End Date field';
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme Join field';
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Medical Scheme Join field';
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Retirement Date field';
                }
            }
            group("Leave Details")
            {
                Caption = 'Leave Details';
                Visible = false;

                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ToolTip = 'Specifies the value of the Annual Leave Days field';
                }
                field("Compassionate Leave Days"; Rec."Compassionate Leave Days")
                {
                    ToolTip = 'Specifies the value of the Compassionate Leave Days field';
                }
                field("Maternity Leave Days"; Rec."Maternity Leave Days")
                {
                    Visible = Visibility;
                    ToolTip = 'Specifies the value of the Maternity Leave Days field';
                }
                field("Paternity Leave Days"; Rec."Paternity Leave Days")
                {
                    Visible = Visibility;
                    ToolTip = 'Specifies the value of the Paternity Leave Days field';
                }
                field("Sick Leave Days"; Rec."Sick Leave Days")
                {
                    ToolTip = 'Specifies the value of the Sick Leave Days field';
                }
                field("Study Leave Days"; Rec."Study Leave Days")
                {
                    ToolTip = 'Specifies the value of the Study Leave Days field';
                }
                field("Other Leave Days (Total)"; Rec."Other Leave Days (Total)")
                {
                    ToolTip = 'Specifies the value of the Other Leave Days (Total) field';
                }
            }
            group(Separation)
            {
                Caption = 'Separation';

                field("Notice Period"; Rec."Notice Period")
                {
                    ToolTip = 'Specifies the value of the Notice Period field';
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ToolTip = 'Specifies the value of the Send Alert to field';
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ToolTip = 'Specifies the value of the Served Notice Period field';
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field';
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Termination Category field';
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Exit Interview Date field';
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Exit Interview Done by field';
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Allow Re-Employment In Future field';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action(SendApproval1)
            {
                Caption = 'Effect Changes';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    // if Rec."Approval Status" <> Rec."Approval Status"::Approved then Error('Kindl send to Approval First');
                    Employee.Reset();
                    Employee.SetRange("No.", Rec."No.");
                    if Employee.Find('-') then
                        if Rec."First Name" <> '' then
                            employee."First Name" := Rec."First Name";
                    if Rec."Middle Name" <> '' then
                        employee."Middle Name" := Rec."Middle Name";
                    if Rec."Last Name" <> '' then
                        employee."Last Name" := Rec."Last Name";
                    // Initials
                    if Rec.Initials <> '' then
                        employee.Initials := Rec.Initials;
                    if rec."ID No." <> '' then
                        employee."ID No." := Rec."ID No.";
                    if Rec."Passport Number" <> '' then
                        employee."Passport Number" := Rec."Passport No.";
                    if Rec."Driving Licence" <> '' then
                        employee."Driving Licence" := Rec."Driving Licence";
                    if Rec."Phone No." <> '' then
                        employee."Phone No." := Rec."Phone No.";
                    if Rec."E-Mail" <> '' then
                        employee."E-Mail" := Rec."E-Mail";
                    if Rec.Address <> '' then
                        employee.Address := Rec.Address;
                    if Rec."Post Code" <> '' then
                        employee."Post Code" := Rec."Post Code";
                    if Rec.City <> '' then
                        employee.City := Rec.City;
                    if Rec.Gender <> Rec.Gender::" " then
                        employee.Gender := rec.Gender;
                    if Rec.Disability <> '' then
                        employee.Disabled := rec.Disabled;
                    if Rec."Disability Certificate" <> '' then
                        employee."Disability Certificate" := rec."Disability Certificate";
                    if Rec."Marital Status" <> Rec."Marital Status"::" " then
                        employee."Marital Status" := Rec."Marital Status";
                    if Rec.County <> '' then
                        employee.County := Rec.County;
                    if Rec.Religion <> '' then
                        employee.Religion := Rec.Religion;
                    Employee.Modify();
                    Message('Change Made Successfully');
                    CurrPage.Close();
                end;
            }
            action("Next of Kin")
            {
                ApplicationArea = BasicHR;
                Caption = 'Next of Kin';
                Image = Relatives;
                RunObject = page "Employee Relatives";
                RunPageLink = "Employee No." = field("No.");
                RunPageMode = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Open the list of relatives that are registered for the employee.';
            }
            action("Absences by Ca&tegories")
            {
                ApplicationArea = BasicHR;
                Caption = 'Absences by Ca&tegories';
                Image = AbsenceCategory;
                RunObject = page "Empl. Absences by Categories";
                RunPageLink = "No." = field("No."),
                                  "Employee No. Filter" = field("No.");
                ToolTip = 'View categorized absence information for the employee.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
            }
            action("Yearly Bonus")
            {
                Image = Holiday;
                ToolTip = 'Executes the Yearly Bonus action';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                trigger OnAction()
                begin

                    Payroll.GetYearlyBonus(Rec."No.");
                end;
            }
            action("Acting Positions")
            {
                Image = EditCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Acting Duties List";
                RunPageLink = "Acting Employee No." = field("No.");
                Visible = false;
                ToolTip = 'Executes the Acting Positions action';
            }
            action(Beneficiaries)
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Employee Beneficiaries";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'Executes the Beneficiaries action';
            }


            action("Send For Approval")
            {
                Caption = 'Send Approval Request';
                Enabled = Rec."Approval Status" = Rec."Approval Status"::Open;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                var
                    LeaveType: Record "Leave Type";
                begin



                    if Confirm('Send Approval Request for changes %1 ', false, Rec.Name) = false then begin
                        Message('Cancelled');
                        exit;
                    end
                    else begin
                        ApprovalsCodeUnit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);
                        Message('Approval Request Sent Successfully');
                    end;

                    CurrPage.Close();

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = Rec."Approval Status" = Rec."Approval Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelEmployeeChangeApproval(rec);

                end;
            }





        }





    }

    trigger OnInit()
    begin
        ContractView := false;
        DisabilityView := false;
    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible();
        SetLecturerVisible();
        SetContractView();
        DisabilityView := false;
    end;

    var
        ApprovalsCodeUnit: Codeunit "Altairetro ApprovalsCodeUnit";

        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        ApprovalManagement: Codeunit "Approval Mgt HR Ext";
        Banks: Record Banks;
        Employee: Record Employee;
        PayPeriod: Record "Payroll Period II";
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        ProbationPeriod: DateFormula;
        ContractView: Boolean;
        DisabilityView: Boolean;
        IsLecturerVisible: Boolean;
        NoFieldVisible: Boolean;
        Visibility: Boolean;
        CurrentMonth: Date;
        Text0001: Label 'Do you want to send the payslip?';
        BankName: Text;

    local procedure ContractFields()
    begin
        /*//"Contract Type":='';
        "Contract Number":=0;
        "Contract Start Date":=0D;
        "Contract End Date":=0D;
        "Send Alert to":='';
        Modify();
        */

    end;

    local procedure Disability()
    begin
        if Rec."No." <> '' then
            if Rec.Disabled = Rec.Disabled::No then
                DisabilityView := false
            else
                DisabilityView := true;
    end;

    local procedure DisabilityField()
    begin
        Rec.Disability := '';
    end;

    local procedure GetCurrentPayPeriod(): Date
    begin
        PayPeriod.Reset();
        PayPeriod.SetRange(Closed, false);
        if PayPeriod.FindFirst() then
            exit(PayPeriod."Starting Date");
    end;

    local procedure SetContractView()
    begin
        if Rec."No." <> '' then
            if Rec."Nature of Employment" <> 'CONTRACT' then
                ContractView := false
            else
                ContractView := true;
    end;

    local procedure SetLecturerVisible()
    begin
        if Rec."Is Lecturer" = true then
            IsLecturerVisible := true
        else
            IsLecturerVisible := false;
    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;
}





