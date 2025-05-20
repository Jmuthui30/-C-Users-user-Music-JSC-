report 51611 "Facilitator Evaluation"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Facilitator Evaluation.rdlc';

    dataset
    {
        dataitem("Training Evaluation"; "Training Evaluation")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(TitleOfAcademy; TitleOfAcademy)
            {
            }
            column(NameOfFacilitator; "Training Evaluation"."Name of Facilitator")
            {
            }
            column(CourseTitle; "Training Evaluation"."Course Title")
            {
            }
            column(Date; "Training Evaluation"."End Date")
            {
            }
            column(ClearObjectives; "Training Evaluation"."Clear objectives")
            {
            }
            column(Organization; "Training Evaluation".Organization)
            {
            }
            column(Ease; "Training Evaluation".Ease)
            {
            }
            column(Usefulness; "Training Evaluation".Usefulness)
            {
            }
            column(MeetingObjectives; "Training Evaluation"."Meeting Objectives")
            {
            }
            column(AddressNonCompliance; "Training Evaluation"."Addresses Non-compliance")
            {
            }
            column(ParticipantsEngagement; "Training Evaluation"."Participants Engagement")
            {
            }
            column(PracticalExamples; "Training Evaluation"."Pratical Examples")
            {
            }
            column(PrsocialBehaviour; "Training Evaluation"."Pro-social behaviour")
            {
            }
            column(ConstructiveFeedback; "Training Evaluation"."Constructive Feedback")
            {
            }
            column(UseOfMaterials; "Training Evaluation"."Use of materials")
            {
            }
            column(Competency; "Training Evaluation".Competency)
            {
            }
            column(CommunicationSkills; "Training Evaluation"."Communication Skills")
            {
            }
            column(GeneralObservations; "Training Evaluation"."General Observations")
            {
            }
            column(AreasOfImprovement; "Training Evaluation"."Areas of Improvement")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        StrPosNo:=StrPos(CompInfo.Name, ' ');
        if StrPosNo <> 0 then TitleOfAcademy:=UpperCase(CopyStr(CompInfo.Name, 1, StrPosNo) + ' ' + 'ACADEMY')
        else
            TitleOfAcademy:=UpperCase(CompInfo.Name + ' ' + 'ACADEMY');
    end;
    var CompInfo: Record "Company Information";
    TitleOfAcademy: Text;
    StrPosNo: Integer;
}
