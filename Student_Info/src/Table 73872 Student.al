table 73872 Student
{
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; DOB; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Contact; Text[10])
        {
            Caption = 'Contact';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(5; Email; Text[30])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(6; "Student Picture"; BLOB)
        {
            Caption = 'Student Picture';
            SubType = Bitmap;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}