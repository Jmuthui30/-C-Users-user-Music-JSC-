report 51022 "Votebook Summary-New"
{
    ApplicationArea = All;
    Caption = 'Votebook Summary';
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './src/report_layout/VotebookSummaryNew.rdlc';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Budget Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; CompanyProperty.DisplayName())
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(AccountType_GLAccount; "G/L Account"."Account Type")
            {
            }
            column(GLBudgetFilterCaption; GLBudgetFilterCaptionLbl)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            column(GLBudgetFilter; GLBudgetFilter)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                    DecimalPlaces = 0 : 0;
                }
                // column(CommittedAmount; "G/L Account".Commitment)
                // {
                // }
                // column(EncumeranceAmount; "G/L Account".Encumberance)
                // {
                // }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(G_L_Account___Budgeted_Amount_; +"G/L Account"."Budgeted Amount")
                {
                    DecimalPlaces = 0 : 0;
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    DataItemTableView = sorting(Number);

                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break();

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;
            }

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;
            end;

            trigger OnAfterGetRecord()
            begin
                //   CalcFields("Net Change", "Balance at Date", "Budgeted Amount", Commitment, Encumberance);

                if ChangeGroupNo then begin
                    PageGroupNo += 1;
                    ChangeGroupNo := false;
                end;

                ChangeGroupNo := "New Page";
            end;
        }
    }
    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        PageGroupNo: Integer;
        BalanceCaptionLbl: Label 'Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        GLBudgetFilterCaptionLbl: Label 'Budget Filter';
        Net_ChangeCaptionLbl: Label 'Net Change';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        Text000: Label 'Period: %1';
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        GLFilter: Text;
        GLBudgetFilter: Text[30];
        PeriodText: Text[30];

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
        GLBudgetFilter := "G/L Account".GetFilter("Budget Filter");
        if GLBudgetFilter = '' then
            Error('Please input Budget Filter');

        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;
}
