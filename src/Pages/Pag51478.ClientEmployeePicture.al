page 51478 "Client Employee Picture"
{
    // version THL- Client Payroll 1.0
    Caption = 'Employee Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Client Employee Master";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the employee.';
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;
    trigger OnOpenPage()
    begin
    /*CameraAvailable := CameraProvider.IsAvailable;
        IF CameraAvailable THEN
          CameraProvider := CameraProvider.Create;
          */
    end;
    var CameraAvailable: Boolean;
    OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
    DeleteImageQst: Label 'Are you sure you want to delete the picture?';
    SelectPictureTxt: Label 'Select a picture to upload';
    DeleteExportEnabled: Boolean;
    DownloadImageTxt: Label 'Download image';
    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled:=Rec.Picture.HasValue;
    end;
}
