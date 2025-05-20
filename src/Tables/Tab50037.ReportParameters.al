table 50037 "Report Parameters"
{
    Caption = 'Report Parameters';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ReportId; Integer)
        {
            Caption = 'ReportId';
        }
        field(2; UserId; Code[50])
        {
            Caption = 'UserId';
        }
        field(3; Parameters; Blob)
        {
            Caption = 'Parameters';
        }
    }
    keys
    {
        key(PK; ReportId, UserId)
        {
            Clustered = true;
        }
    }
}
