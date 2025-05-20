table 51804 "Store Transaction Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Transaction; Option)
        {
            OptionCaption = ' ,Receive,Issue,Transfer';
            OptionMembers = " ", Receive, Issue, Transfer;
        }
        field(4; From; Option)
        {
            OptionCaption = ' ,Direct Purchase,Supplier,Location,Employee';
            OptionMembers = " ", "Direct Purchase", Supplier, Location, Employee;

            trigger OnValidate()
            begin
                FetchHeaderDetails("No.");
                GetStaffDetails;
            end;
        }
        field(5; "From No."; Code[20])
        {
            trigger OnLookup()
            begin
                if Format(From) = '' then Error(Text001);
                if From = From::Supplier then begin
                    Supplier.Reset;
                    if PAGE.RunModal(PAGE::Suppliers, Supplier) = ACTION::LookupOK then begin
                        Validate("From No.", Supplier."No.");
                    end;
                end
                else if From = From::Location then begin
                        Locations.Reset;
                        if PAGE.RunModal(PAGE::Locations, Locations) = ACTION::LookupOK then begin
                            Validate("From No.", Locations.Code);
                        end;
                    end
                    else if From = From::Employee then begin
                            Emp.Reset;
                            if PAGE.RunModal(PAGE::"Stores Employee List", Emp) = ACTION::LookupOK then begin
                                Validate("From No.", Emp."No.");
                            end;
                        end;
            end;
            trigger OnValidate()
            begin
                if From = From::Supplier then begin
                    if Supplier.Get("From No.")then "From Description":=Supplier.Name
                    else
                        Error(Text002);
                end
                else if From = From::Location then begin
                        if Locations.Get("From No.")then "From Description":=Locations.Name
                        else
                            Error(Text002);
                    end
                    else if From = From::Employee then begin
                            if Emp.Get("From No.")then "From Description":=Emp."First Name" + ' ' + Emp."Last Name"
                            else
                                Error(Text002);
                        end;
            end;
        }
        field(6; "From Description"; Text[50])
        {
        }
        field(7; "Item No."; Code[10])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                if Cert.Get("Item No.")then begin
                    "Item Description":=Cert.Description;
                    Validate("Unit Value", Cert."Unit Cost");
                //"Unit Value" := Cert."Unit Cost";
                //"Unit of Measure" := Cert."Base Unit of Measure";
                end;
            end;
        }
        field(8; "Item Description"; Text[50])
        {
        }
        field(9; Quantity; Integer)
        {
            trigger OnValidate()
            begin
                FetchHeaderDetails("No.");
                Validate("Unit Value");
                if Transaction = Transaction::Issue then "Inventory Changes":=-Quantity
                else if Transaction = Transaction::Receive then "Inventory Changes":=Quantity
                    else if Transaction = Transaction::Transfer then "Inventory Changes":=0;
            end;
        }
        field(10; "Unit Value"; Decimal)
        {
            trigger OnValidate()
            begin
                "Total Value":=Round("Unit Value" * Quantity, 0.01);
            end;
        }
        field(11; "Total Value"; Decimal)
        {
        }
        field(12; "To"; Option)
        {
            OptionCaption = ' ,Employee,Supplier,Location';
            OptionMembers = " ", Employee, Supplier, Location;

            trigger OnValidate()
            begin
                FetchHeaderDetails("No.");
                GetStaffDetails;
            end;
        }
        field(13; "To No."; Code[20])
        {
            trigger OnLookup()
            begin
                if "To" = "To"::Supplier then begin
                    Supplier.Reset;
                    if PAGE.RunModal(PAGE::Suppliers, Supplier) = ACTION::LookupOK then begin
                        Validate("To No.", Supplier."No.");
                    end;
                end
                else if "To" = "To"::Location then begin
                        Locations.Reset;
                        if PAGE.RunModal(PAGE::Locations, Locations) = ACTION::LookupOK then begin
                            Validate("To No.", Locations.Code);
                        end;
                    end
                    else if "To" = "To"::Employee then begin
                            Emp.Reset;
                            if PAGE.RunModal(PAGE::"Stores Employee List", Emp) = ACTION::LookupOK then begin
                                Validate("To No.", Emp."No.");
                            end;
                        end;
            end;
            trigger OnValidate()
            begin
                if "To" = "To"::Supplier then begin
                    if Supplier.Get("To No.")then "To Description":=Supplier.Name
                    else
                        Error(Text002);
                end
                else if "To" = "To"::Location then begin
                        if Locations.Get("To No.")then "To Description":=Locations.Name
                        else
                            Error(Text002);
                    end
                    else if "To" = "To"::Employee then begin
                            if Emp.Get("To No.")then "To Description":=Emp."First Name" + ' ' + Emp."Last Name"
                            else
                                Error(Text002);
                        end;
            end;
        }
        field(14; "To Description"; Text[50])
        {
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(17; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(18; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(19; "Global Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5));
        }
        field(20; "Starting No."; Integer)
        {
            trigger OnValidate()
            begin
                if("Ending No." > 0) and ("Starting No." > 0)then begin
                    if "Ending No." < "Starting No." then Error(Text003);
                    Validate(Quantity, ("Ending No." - "Starting No.") + 1);
                end
                else
                    Validate(Quantity, 0);
            end;
        }
        field(21; "Ending No."; Integer)
        {
            trigger OnValidate()
            begin
                Validate("Starting No.");
            end;
        }
        field(22; "Inventory Changes"; Integer)
        {
        }
        field(23; Posted; Boolean)
        {
        }
        field(24; Date; Date)
        {
        }
        field(25; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No."=FIELD("Item No."));
        }
        field(26; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No."=FIELD("Item No."));
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.", "Item No.")
        {
        }
        key(Key2; Date)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        FetchHeaderDetails("No.");
    end;
    var Header: Record "Store Transaction Header";
    CertSetup: Record "Procurement Setup";
    Text000: Label 'Source and Destionation cannot both be the same.';
    Text001: Label '''From'' and ''To'' cannot be blank!';
    Supplier: Record Vendor;
    Locations: Record Location;
    Text002: Label 'Unknown';
    Cert: Record Item;
    Text003: Label 'Ending No. cannot be smaller than Starting No.';
    UserSetup: Record "User Setup";
    Users: Record User;
    Emp: Record Employee;
    OurEmp: Record "Employee Master";
    local procedure FetchHeaderDetails(var DocNo: Code[20])
    begin
        if Header.Get(DocNo)then begin
            Transaction:=Header.Transaction;
            if Date = 0D then Date:=Header.Date;
            /*
            IF "Global Dimension 1 Code" = '' THEN
            "Global Dimension 1 Code" := Header."Global Dimension 1 Code";
            IF "Global Dimension 2 Code" = '' THEN
            "Global Dimension 2 Code" := Header."Global Dimension 2 Code";
            IF "Global Dimension 3 Code" = '' THEN
            "Global Dimension 3 Code" := Header."Global Dimension 3 Code";
            IF "Global Dimension 4 Code" = '' THEN
            "Global Dimension 4 Code" := Header."Global Dimension 4 Code";
            IF "Global Dimension 5 Code" = '' THEN
            "Global Dimension 5 Code" := Header."Global Dimension 5 Code";
            */
            //
            if Header.Transaction = Header.Transaction::Receive then begin
                if(From <> xRec.From) and (From = From::Employee)then From:=From::Employee
                else
                    From:=From::"Direct Purchase";
                "To":="To"::Location;
                OurEmp.Reset;
                if UserSetup.Get(UserId)then if OurEmp.Get(UserSetup."Employee No.")then Validate("To No.", OurEmp."Global Dimension 2 Code");
            end;
            if Header.Transaction = Header.Transaction::Issue then begin
                From:=From::Location;
                OurEmp.Reset;
                if UserSetup.Get(UserId)then if OurEmp.Get(UserSetup."Employee No.")then Validate("From No.", OurEmp."Global Dimension 2 Code");
                "To":="To"::Employee;
            end;
        end;
    end;
    local procedure GetStaffDetails()
    var
        Vend: Record Vendor;
    begin
        if From = From::"Direct Purchase" then begin
            if UserSetup.Get(UserId)then "From No.":=UserSetup."Employee No.";
            if Users.Get(UserSecurityId)then "From Description":=Users."Full Name";
        end;
        if From = From::Employee then begin
            Emp.Reset;
            if PAGE.RunModal(PAGE::"Stores Employee List", Emp) = ACTION::LookupOK then begin
                Validate("From No.", Emp."No.");
            end;
        end;
        if "To" = "To"::Employee then begin
            Emp.Reset;
            if PAGE.RunModal(PAGE::"Stores Employee List", Emp) = ACTION::LookupOK then begin
                Validate("To No.", Emp."No.");
            end;
        end;
    end;
}
