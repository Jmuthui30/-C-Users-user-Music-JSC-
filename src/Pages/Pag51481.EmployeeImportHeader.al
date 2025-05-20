page 51481 "Employee Import Header"
{
    // version THL- Client Payroll 1.0
    PageType = Card;
    SourceTable = "Employee Import Header";
    SourceTableView = WHERE(Posted=CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control12; "Employee Import Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control14; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Import Data Sheet")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    EmpData.GetHeader(Rec);
                    EmpData.Run;
                end;
            }
            action("Create Employee Records")
            {
                ApplicationArea = All;
                Image = CoupledUsers;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Lines.Reset;
                    Lines.SetRange("No.", Rec."No.");
                    if Lines.FindSet then begin
                        repeat Employee.Init;
                            Employee."No.":=Lines."System No.";
                            Employee."Pays Tax":=true;
                            Employee."ID Number":=Lines."ID Number";
                            Employee."Passport No.":=Lines."Passport Number";
                            if UpperCase(Lines."Marital Status") = 'MARRIED' then Employee."Marital Status":=Employee."Marital Status"::Married
                            else if UpperCase(Lines."Marital Status") = 'SINGLE' then Employee."Marital Status":=Employee."Marital Status"::Single
                                else if UpperCase(Lines."Marital Status") = 'SEPARATED' then Employee."Marital Status":=Employee."Marital Status"::Separated
                                    else if UpperCase(Lines."Marital Status") = 'DIVORCED' then Employee."Marital Status":=Employee."Marital Status"::Divorced
                                        else if(UpperCase(Lines."Marital Status") = 'WIDOW') or (UpperCase(Lines."Marital Status") = 'WIDOWER')then Employee."Marital Status":=Employee."Marital Status"::"Widow(er)";
                            Employee."PIN Number":=Lines."PIN No.";
                            Employee."NSSF No":=Lines."NSSF No.";
                            Employee."SHIF No":=Lines."SHIF No.";
                            Employee."HELB No":=Lines."HELB No.";
                            Employee."Sacco No":=Lines."Sacco Number";
                            Employee."Bank Account Number":=Lines."Account Number";
                            Employee.Validate("Bank Code", Lines."Bank Code");
                            Employee."Contract Type":=Lines."Contract Type";
                            Employee."Starting Date":=Lines."Starting Date";
                            Employee.Validate("Departure Date", Lines."Departture Date");
                            Employee.Validate("Bank Branch", Lines."Branch Code");
                            Employee."Payroll No.":=Lines."Payroll No.";
                            Employee.Validate("Full Name", Lines."Full Name");
                            Employee.Title:=Lines.Title;
                            Employee.Validate("Company Code", Lines.Company);
                            Employee.Validate(Department, Lines.Department);
                            if Lines.Gender = 'MALE' then Employee.Gender:=Employee.Gender::Male
                            else
                                Employee.Gender:=Employee.Gender::Female;
                            Employee."Date of Birth":=Lines."Date of Birth";
                            Employee."Postal Address":=Lines."Postal Address";
                            Employee."Mobile Phone No.":=Lines."Mobile Phone No.";
                            Employee."Email Address":=Lines."Email Address";
                            if not Emp.Get(Employee."No.")then Employee.Insert;
                        until Lines.Next = 0;
                    end;
                    Rec.Posted:=true;
                    Rec."Posted By":=UserId;
                    Rec."Posted Date":=Today;
                    Rec.Modify;
                end;
            }
        }
    }
    var EmpData: XMLport "Import Employee Details";
    Employee: Record "Client Employee Master";
    Lines: Record "Employee Import Lines";
    Emp: Record "Client Employee Master";
}
