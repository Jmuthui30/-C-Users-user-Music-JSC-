table 51811 "Invitation to Travel Order"
{
    fields
    {
        field(1; "TO No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Employee No.");
                if Cust.Find('-')then begin
                    Name:=Cust.Name;
                    "Phone No.":=Cust."Phone No." end;
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; "Date of Request"; Date)
        {
            Editable = false;
        }
        field(5; "Departure Location"; Text[50])
        {
        }
        field(6; "Departure Date"; Date)
        {
        }
        field(7; Purpose; Text[50])
        {
        }
        field(8; "No Of Days"; Decimal)
        {
        }
        field(9; Itenary; Text[150])
        {
        }
        field(10; "Variation Authorized"; Boolean)
        {
        }
        field(11; Bus; Boolean)
        {
            Description = 'travel by';
        }
        field(12; Rail; Boolean)
        {
            Description = 'travel by';
        }
        field(13; POV; Boolean)
        {
            Description = 'travel by';
        }
        field(14; "Commercial Air"; Boolean)
        {
            Description = 'travel by';
        }
        field(15; "Govt Vehicle"; Boolean)
        {
            Description = 'travel by';
        }
        field(16; Project; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3), Blocked=FILTER(false));
        }
        field(17; "Requested By"; Code[50])
        {
            Editable = false;
        }
        field(18; "Supervisor ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup";
        }
        field(19; "Supervisor Date"; Date)
        {
            Editable = true;
        }
        field(20; "Resource Mgt ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup";
        }
        field(21; "Resource Date"; Date)
        {
        }
        field(22; "USAMRU-K Command ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup";
        }
        field(23; "USAMRU-K Command Date"; Date)
        {
            Caption = 'USAMRU-K Command Approval Date';
            Editable = true;
        }
        field(24; Location; Code[20])
        {
            TableRelation = "AEA Listing".Location;

            trigger OnValidate()
            begin
                LocalityRec.Reset;
                LocalityRec.SetRange(LocalityRec.Location, Location);
                if LocalityRec.Find('-')then begin
                    maxAeA:=LocalityRec."Maximum Perdiem Rate";
                    MIE:=LocalityRec."M&IE";
                end;
            end;
        }
        field(25; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(26; "Authorized Advance"; Decimal)
        {
        }
        field(27; Status; Option)
        {
            OptionCaption = 'New,Approval Pending,Approved,Rejected';
            OptionMembers = New, "Approval Pending", Confirmed, Rejected;
        }
        field(28; Comments; Text[250])
        {
        }
        field(29; Amount; Decimal)
        {
        }
        field(30; "Action ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup";
        }
        field(31; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Site Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(32; "Approval Status"; Option)
        {
            Editable = true;
            OptionCaption = 'New,Supervisor Approval,Resource Mgt Approval,Chief Of Staff,USAMRU-K Command Approval,Approved,Rejected,Finance';
            OptionMembers = New, "Supervisor Approval", "Resource Mgt Approval", "Chief Of Staff", "USAMRU-K Command Approval", Approved, Rejected, Finance;
        }
        field(33; "Return Date"; Date)
        {
        }
        field(34; "Return Location"; Text[70])
        {
        }
        field(35; "Chief Of Staff Date"; Date)
        {
            Editable = true;
        }
        field(36; "Chief of Staff ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup";
        }
        field(37; "International TDY"; Boolean)
        {
        }
        field(38; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(39; "No Cost Associated"; Boolean)
        {
        }
        field(40; "Daily Lodging"; Boolean)
        {
        }
        field(41; "Meals Provided"; Boolean)
        {
        }
        field(42; Breakfast; Boolean)
        {
        }
        field(43; Lunch; Boolean)
        {
        }
        field(44; Dinner; Boolean)
        {
        }
        field(45; "Rental Car"; Boolean)
        {
        }
        field(46; "Time wanted"; Time)
        {
        }
        field(47; "Date Wanted"; Date)
        {
        }
        field(48; "Driver Required"; Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ", Yes, No;
        }
        field(49; "# of passengers"; Integer)
        {
        }
        field(50; "Requested for No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Requested for No.");
                if Cust.Find('-')then begin
                    "Requested for Name":=Cust.Name;
                end;
            end;
        }
        field(51; "Requested for Name"; Text[50])
        {
        }
        field(52; "Shortcut Dimension 3 Code"; Code[10])
        {
            CaptionClass = '1,2,3';
            Caption = 'Project Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3), Blocked=FILTER(false));
        }
        field(53; "Pick up location"; Text[100])
        {
        }
        field(54; "Stop Location(s)"; Text[100])
        {
        }
        field(55; Destination; Text[100])
        {
        }
        field(56; "Type and amount of cargo"; Text[100])
        {
        }
        field(57; "Estimated Distance of travel"; Decimal)
        {
        }
        field(58; "Supervisor/PI"; Code[100])
        {
        }
        field(59; "Supervisor/PI Date"; Date)
        {
        }
        field(60; "Supervisor/PI Telephone"; Text[100])
        {
        }
        field(61; "Time request received"; DateTime)
        {
        }
        field(62; "Request Received By"; Code[100])
        {
        }
        field(63; "Reg No"; Code[20])
        {
            TableRelation = "Fixed Asset" WHERE("FA Class Code"=FILTER('VEHICLES'));
        }
        field(64; "Driver No"; Code[20])
        {
            TableRelation = Resource WHERE("Resource Group No."=FILTER('DRIVERS'));

            trigger OnValidate()
            begin
                Resource.Reset;
                Resource.SetRange(Resource."No.", "Driver No");
                if Resource.Find('-')then begin
                    "Driver Name":=Resource.Name;
                end;
            end;
        }
        field(65; "Driver Name"; Text[100])
        {
        }
        field(66; "TMP Coordinator"; Code[100])
        {
        }
        field(67; "TMP Coordinator Date"; Date)
        {
        }
        field(68; "Approving Authority"; Code[100])
        {
        }
        field(69; "Approving Authority Date"; Date)
        {
        }
        field(70; "Start Odometer Reading"; Integer)
        {
        }
        field(71; "End Odometer reading"; Integer)
        {
        }
        field(73; "Fund No."; Code[10])
        {
            Caption = 'Programme No.';
        }
        field(74; Type; Option)
        {
            OptionCaption = ' ,Transport';
            OptionMembers = " ", Transport;
        }
        field(75; "Finance ID"; Code[50])
        {
            Editable = true;
            TableRelation = "User Setup";
        }
        field(76; "Finance Date"; Date)
        {
        }
        field(77; "Unit Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Unit Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(78; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
    }
    keys
    {
        key(Key1; "TO No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Cust: Record Customer;
    LocalityRec: Record "AEA Listing";
    MIE: Decimal;
    maxAeA: Decimal;
    PurchSetup: Record "Purchases & Payables Setup";
    Noseriesmgt: Codeunit NoSeriesManagement;
    usersetup: Record "User Setup";
    Resource: Record Resource;
}
