tableextension 51429 "ExtService Line" extends "Service Line"
{
    fields
    {
        field(51423; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Archived';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected, Archived;
        }
        field(51424; "Issuing Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51425; "Customer Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51426; "Store Req. Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51427; "Raised by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51428; "Price MarkUp %"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    Item.SETRANGE("No.", Rec."No.");
                    IF Item.FINDFIRST THEN BEGIN
                        IF "Price MarkUp %" <> 0 THEN BEGIN
                            "Unit Price":=(Item."Unit Cost") + ((Item."Unit Cost") * ("Price MarkUp %" / 100));
                            "Line Amount":="Unit Price" * Quantity;
                            "Total Line Cost":=Item."Unit Cost" * Quantity;
                        END
                        ELSE
                        BEGIN
                            "Unit Price":=Item."Unit Cost";
                            "Line Amount":="Unit Price" * Quantity;
                            "Total Line Cost":=Item."Unit Cost" * Quantity;
                        END;
                    END;
                END;
            end;
        }
        field(51429; "Fully Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51430; "Store Issue"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51431; "Total Line Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}
