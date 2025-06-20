report 53060 "Job Applicant Submitted"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSub;

    dataset
    {
        dataitem(JobApplicationReg; "Job Application")
        {
            RequestFilterFields = "Job Applied Code", "Job Title", "No.", "Recruitment Needs No.";
            DataItemTableView = where(Submitted = filter(true));

            column(No_; "No.") { }
            column(Applicant_No_; "Applicant No.") { }
            column(Applicant_Name; "Applicant Name") { }
            column(Gender; Gender) { }
            column(Job_Applied_Code; "Job Applied Code") { }
            column(Job_Title; "Job Title") { }
            column(Date_Time_Created; "Date-Time Created") { }
            column(Submitted; Submitted) { }
            column(Age; Age) { }
            column(Date_of_Birth; "Date of Birth") { }
            dataitem(IntegerTab; Integer)
            {

                column(Number; Number)
                {

                }
                Column(Caption; arrFieldCaptions[Number])
                {

                }
                Column(Dat; arrFieldValues[Number])
                {

                }
                trigger OnPreDataItem()
                begin
                    IntegerTab.SetRange(Number, 1, arrayIndex);
                end;
            }

            Trigger OnAfterGetRecord()
            var
                Recref: RecordRef;
                FieldRef: FieldRef;
            Begin

                Clear(Recref);
                Clear(FieldRef);
                Clear(arrFieldValues);
                Clear(arrayIndex);
                for arrayIndex := 1 to arrlength do begin
                    recref.GetTable(JobApplicationReg);
                    FieldRef := recref.Field(arrFieldIds[arrayIndex]);
                    arrFieldValues[arrayIndex] := fieldref.Value();
                end;
            End;
        }
    }

    requestpage
    {
        AboutTitle = 'Job Applicant Report Options';
        AboutText = 'Select which fields to include in the report output';

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(ShowGender; ShowGender)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Gender';
                        ToolTip = 'Specifies whether to show the Gender column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Gender));

                        end;
                    }
                    field(ShowAge; ShowAge)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Age';
                        ToolTip = 'Specifies whether to show the Age column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Age));

                        end;
                    }
                    field(ShowDateOfBirth; ShowDateOfBirth)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Date of Birth';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Date of Birth"));

                        end;

                    }


                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            fieldref: FieldRef;
            Recref: RecordRef;
        Begin
            compinfo.Get();
            Compinfo.CalcFields(compinfo.Picture);
            arrlength := arrayIndex;
            Clear(arrayIndex);
            for arrayIndex := 1 to arrlength do begin
                Recref.GetTable(JobApplicationReg);
                fieldref := recref.Field(arrFieldIds[arrayIndex]);
                arrFieldCaptions[arrayIndex] := FieldRef.Caption();
            end;
            Clear(arrayIndex);
            //Nofcolums := 
        end;
    }

    rendering
    {
        layout(ApplSub)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ApplJobSumitted_list.RDLC';
            Caption = 'Job Submitted';
        }
    }

    trigger OnInitReport()
    begin


    end;

    var
        [InDataSet]
        ShowGender: Boolean;
        ShowAge: Boolean;
        ShowDateOfBirth: Boolean;
        arrayIndex: Integer;
        compinfo: Record "Company Information";
        arrlength: Integer;

        arrFieldIds: array[20] of Integer;
        arrFieldCaptions: array[20] of Text;
        arrFieldValues: array[20] of Text;
        Appl: Record "Job Application";

    local procedure InitalizeFieldIds(fieldNo: Integer)
    begin
        arrayIndex += 1;
        arrFieldIds[arrayIndex] := fieldNo;
    end;
}