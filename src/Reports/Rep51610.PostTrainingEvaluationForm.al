report 51610 "Post-Training Evaluation Form"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Post-Training Evaluation Form.rdlc';

    dataset
    {
        dataitem("Training Evaluation"; "Training Evaluation")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(StaffNames; "Training Evaluation"."Employee Name")
            {
            }
            column(DimOne; "Training Evaluation"."Global Dimension 1 Code")
            {
            }
            column(DimTwo; "Training Evaluation"."Global Dimension 2 Code")
            {
            }
            column(DimThree; "Training Evaluation"."Global Dimension 3 Code")
            {
            }
            column(JobTitle; "Training Evaluation"."Job Title")
            {
            }
            column(CourseAttended; "Training Evaluation"."Course Title")
            {
            }
            column(Venue; "Training Evaluation".Venue)
            {
            }
            column(Organizers; "Training Evaluation".Organizers)
            {
            }
            column(RelevanceOfCourse; "Training Evaluation"."Relevance of Course")
            {
            }
            column(SkillOne; "Training Evaluation"."Learned Skill 1")
            {
            }
            column(SkillTwo; "Training Evaluation"."Learned Skill 2")
            {
            }
            column(SkillThree; "Training Evaluation"."Learned Skill 3")
            {
            }
            column(MaterialCovered; "Training Evaluation"."Material Covered")
            {
            }
            column(RateTheTraining; "Training Evaluation"."Rate the Training")
            {
            }
            column(CourseContent; "Training Evaluation"."Couse Content")
            {
            }
            column(Notes; "Training Evaluation".Notes)
            {
            }
            column(Presentation; "Training Evaluation".Presentation)
            {
            }
            column(RelevanceRating; "Training Evaluation"."Relevance Rating")
            {
            }
            column(Recommend; "Training Evaluation".Recommend)
            {
            }
            column(Comments; "Training Evaluation".Comments)
            {
            }
            column(HRComments; "Training Evaluation"."HR Comments")
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
    end;
    var CompInfo: Record "Company Information";
}
