table 51126 "DSA Rates"
{
    Caption = 'Grades Scale Rates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Group"; Code[30])
        {
            Caption = 'Job Group';
            TableRelation = "Client Salary Scale".Scale;
        }
        field(2; Rates; Decimal)
        {
            Caption = 'Rates';
        }
        field(30; DSA; Decimal)
        {
            Caption = 'DSA';

            trigger OnValidate()
            begin

            end;
        }
        field(31; "Air Ticket"; Decimal)
        {
            Caption = 'Air Ticket';

            trigger OnValidate()
            begin

            end;
        }
        field(32; Conference; Decimal)
        {
            Caption = 'Conference';

            trigger OnValidate()
            begin

            end;
        }
        field(33; "Ground Transport"; Decimal)
        {
            Caption = 'Ground Transport';

            trigger OnValidate()
            begin

            end;
        }
        field(34; "Cordination Allowance"; Decimal)
        {
            Caption = 'Cordination Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(35; "Facilitator Allowance"; Decimal)
        {
            Caption = 'Facilitator Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(36; "Secretariat Allowance"; Decimal)
        {
            Caption = 'Secretariat Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(37; "Out of Pocket Allowance"; Decimal)
        {
            Caption = 'Out of Pocket Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(38; "Rapporteur Allowance"; Decimal)
        {
            Caption = 'Rapporteur Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(39; "Driver Allowance"; Decimal)
        {
            Caption = 'Driver Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(40; "Retreat Allowance"; Decimal)
        {
            Caption = 'Retreat Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(41; "Expert Allowance"; Decimal)
        {
            Caption = 'Expert Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(42; Accomodation; Decimal)
        {
            Caption = 'Accomodation';

            trigger OnValidate()
            begin

            end;
        }
        field(43; "Tuition Fee"; Decimal)
        {
            Caption = 'Tuition Fee';

            trigger OnValidate()
            begin

            end;
        }
        field(44; "Mileage Allowance"; Decimal)
        {
            Caption = 'Mileage Allowance';

            trigger OnValidate()
            begin

            end;
        }
        field(45; "Quarter Per Diem"; Decimal)
        {
            Caption = 'Quarter Per Diem';

            trigger OnValidate()
            begin

            end;
        }
    }
    keys
    {
        key(PK; "Job Group")
        {
            Clustered = true;
        }
    }
}
