tableextension 51432 "ExtFixed Asset" extends "Fixed Asset"
{
    fields
    {
        modify("FA Subclass Code")
        {
        trigger OnAfterValidate()
        begin
            AssetTaggingGenerator;
        end;
        }
        modify("FA Location Code")
        {
        trigger OnAfterValidate()
        begin
            AssetTaggingGenerator;
        end;
        }
        // Add changes to table fields here
        field(51423; "Resource No."; Code[20])
        {
            TableRelation = Resource;
        }
        //Ibrahim Wasiu
        field(51424; "Asset Status Code"; Code[20])
        {
            TableRelation = "Fixed Asset Status";
        }
        field(51425; "Asset Tagging"; Code[20])
        {
            Editable = false;
        }
        field(51426; "Asset Created Date"; Date)
        {
            trigger OnValidate()
            begin
                AssetTaggingGenerator;
            end;
        }
        field(51427; "Asset DateFormat"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    var myInt: Integer;
    local procedure AssetTaggingGenerator()
    var
        Counter: Integer;
        TagInt: Code[10];
    begin
        Counter:=0;
        TagInt:='';
        if(("FA Subclass Code" <> '') AND ("FA Location Code" <> '') And ("Asset Created Date" <> 0D))then begin
            "Asset DateFormat":=Format("Asset Created Date", 0, '<Year,2>');
            FA.Reset();
            FA.SetFilter("FA Subclass Code", "FA Subclass Code");
            FA.SetFilter("FA Location Code", "FA Location Code");
            FA.SetFilter("Asset DateFormat", "Asset DateFormat");
            IF FA.FindSet then begin
                Counter:=FA.Count;
                Counter:=Counter + 1;
                if Counter < 10 then TagInt:='000' + Format(Counter)
                else if((Counter > 10) And (Counter < 100))then TagInt:='00' + Format(Counter)
                    else if((Counter > 100) and (Counter < 1000))then TagInt:='0' + Format(Counter)
                        else
                            TagInt:=Format(Counter);
                "Asset Tagging":="FA Subclass Code" + "FA Location Code" + "Asset DateFormat" + TagInt;
            end
            else
            begin
                "Asset Tagging":="FA Subclass Code" + "FA Location Code" + "Asset DateFormat" + '0001';
            end;
        end;
    end;
    //End: Ibrahim Wasiu
    var FA: Record "Fixed Asset";
}
