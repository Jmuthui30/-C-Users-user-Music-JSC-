page 51442 "Payroll Activities"
{
    // version THL- Payroll 1.0
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Client Payroll Cue";

    layout
    {
        area(content)
        {
            cuegroup(Welcome)
            {
                Caption = 'Welcome';
                Visible = TileGettingStartedVisible;

                actions
                {
                    action(GettingStartedTile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Return to Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Learn how to get started with Dynamics 365 for Financials.';

                        trigger OnAction()
                        begin
                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
            cuegroup(Employees)
            {
                Caption = 'Employees';
                Visible = ShowSalesActivities;

                field("Active Employees"; Rec."Active Employees")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Employees';
                    //DrillDownPageID = "HR Employee List";
                    DrillDownPageId = "Client Payroll List";
                    ToolTip = 'Employees Active on Payroll';
                }
                field("Inactive Employees"; Rec."Inactive Employees")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inactive Employees';
                    DrillDownPageID = "Client Payroll List";
                    LookupPageID = "Client Payroll List";
                    ToolTip = 'Employees Suspended from Payroll';
                }
            }
        }
    }
    /*
    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
            group("Show/Hide Activities")
            {
                Caption = 'Show/Hide Activities';
                Image = Answers;
                action("Sales ")
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Sales';
                    Image = Sales;
                    RunObject = Codeunit Codeunit1329;
                }
                action(Purchases)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Codeunit Codeunit1331;
                }
                action(Payments)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Payments';
                    Image = Payment;
                    RunObject = Codeunit Codeunit1332;
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Suite;
                    Caption = 'Incoming Documents';
                    Image = Documents;
                    RunObject = Codeunit Codeunit1333;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                }
                action(Start)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Start';
                    Image = NewDocument;
                    RunObject = Codeunit Codeunit1328;
                }
            }
        }
    }
    */
    trigger OnAfterGetCurrRecord()
    begin
        O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible, ReplayGettingStartedVisible);
    end;
    trigger OnAfterGetRecord()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        CalculateCueFieldValues;
        ShowDocumentsPendingDocExchService:=false;
        if DocExchServiceSetup.Get then ShowDocumentsPendingDocExchService:=DocExchServiceSetup.Enabled;
        SetActivityGroupVisibility;
    end;
    trigger OnInit()
    begin
        O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible, ReplayGettingStartedVisible);
    end;
    trigger OnOpenPage()
    var
        OCRServiceMgt: Codeunit "OCR Service Mgt.";
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin
    /*RESET;
        IF NOT GET THEN BEGIN
          INIT;
          INSERT;
        END;
        SETFILTER("Due Date Filter",'>=%1',WORKDATE);
        SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        SETFILTER("Due Next Week Filter",'%1..%2',CALCDATE('<1D>',WORKDATE),CALCDATE('<1W>',WORKDATE));
        SETRANGE("User ID Filter",USERID);
        
        HasCamera := CameraProvider.IsAvailable;
        IF HasCamera THEN
          CameraProvider := CameraProvider.Create;
        
        IF UserTours.IsAvailable THEN BEGIN
          UserTours := UserTours.Create;
          UserTours.NotifyShowTourWizard;
          IF O365GettingStartedMgt.IsGettingStartedSupported THEN
            UserTours.ShowPlayer
          ELSE
            UserTours.HidePlayer;
        END ELSE
          IF PageNotifier.IsAvailable THEN BEGIN
            PageNotifier := PageNotifier.Create;
            PageNotifier.NotifyPageReady;
          END;
        
        ShowCamera := TRUE;
        ShowStartActivities := TRUE;
        ShowSalesActivities := TRUE;
        ShowPurchasesActivities := TRUE;
        ShowPaymentsActivities := TRUE;
        ShowIncomingDocuments := TRUE;
        ShowAwaitingIncomingDoc := OCRServiceMgt.OcrServiceIsEnable;
        
        RoleCenterNotificationMgt.ShowNotifications;
        */
    end;
    var ActivitiesMgt: Codeunit "Activities Mgt.";
    /*Commented by Henry*/
    //CueSetup: Codeunit "Cue Setup";
    O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
    HasCamera: Boolean;
    ShowCamera: Boolean;
    ShowDocumentsPendingDocExchService: Boolean;
    ShowStartActivities: Boolean;
    ShowIncomingDocuments: Boolean;
    ShowPaymentsActivities: Boolean;
    ShowPurchasesActivities: Boolean;
    ShowSalesActivities: Boolean;
    ShowAwaitingIncomingDoc: Boolean;
    TileGettingStartedVisible: Boolean;
    ReplayGettingStartedVisible: Boolean;
    local procedure CalculateCueFieldValues()
    begin
    /*IF FIELDACTIVE("Overdue Sales Invoice Amount") THEN
          "Overdue Sales Invoice Amount" := ActivitiesMgt.CalcOverdueSalesInvoiceAmount;
        IF FIELDACTIVE("Overdue Purch. Invoice Amount") THEN
          "Overdue Purch. Invoice Amount" := ActivitiesMgt.CalcOverduePurchaseInvoiceAmount;
        IF FIELDACTIVE("Sales This Month") THEN
          "Sales This Month" := ActivitiesMgt.CalcSalesThisMonthAmount;
        IF FIELDACTIVE("Top 10 Customer Sales YTD") THEN
          "Top 10 Customer Sales YTD" := ActivitiesMgt.CalcTop10CustomerSalesRatioYTD;
        IF FIELDACTIVE("Average Collection Days") THEN
          "Average Collection Days" := ActivitiesMgt.CalcAverageCollectionDays;*/
    end;
    local procedure SetActivityGroupVisibility()
    begin
    /*ShowStartActivities := StartActivitiesMgt.IsActivitiesVisible;
        ShowSalesActivities := SalesActivitiesMgt.IsActivitiesVisible;
        ShowPurchasesActivities := PurchasesActivitiesMgt.IsActivitiesVisible;
        ShowPaymentsActivities := PaymentsActivitiesMgt.IsActivitiesVisible;
        ShowIncomingDocuments := IncDocActivitiesMgt.IsActivitiesVisible;
        ShowCamera := HasCamera AND ShowIncomingDocuments;*/
    end;
}
