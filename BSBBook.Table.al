/// <summary>
/// Table BSB Book (ID 50100).
/// </summary>
table 50100 "BSB Book"
{
    Caption = 'Book';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(5; Type; Enum "BSB Book Type")
        {
            Caption = 'Type';
            // OptionMembers = " ",Hardcover,Paperback;
            // OptionCaption = ' ,Hardcover,Paperback';
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            Editable = false;
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(10; Author; Text[50])
        {
            Caption = 'Author';
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; ISBN; Code[20])
        {
            Caption = 'ISBN';
        }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
            MinValue = 0;
        }
        field(17; "Edition No."; Integer) { Caption = 'Edition No. '; }
        field(18; "Date of publishing"; Date) { Caption = 'Date of publishing'; }
    }
    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author) { }
    }

    var
        OnDeleteErrorLbl: Label 'A book cannot be deleted';

    trigger OnInsert()
    begin
        Created := Today;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        OnBeforeOnDelete(Rec, IsHandled);
        if IsHandled then
            exit;

        Error(OnDeleteErrorLbl);
    end;

    /// <summary>
    /// Checks if a book is blocked or not. If blocked throw an error
    /// </summary>
    /// <param name="BookNo">Code[20]. No. of the book to check.</param>
    procedure TestBlocked(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        BSBBook.Get(BookNo);
        TestBlocked(BSBBook);
    end;

    /// <summary>
    /// Checks if a book is blocked or not on base of Rec. If blocked throw an error.
    /// </summary>
    procedure TestBlocked()
    begin
        TestBlocked(Rec);
    end;

    local procedure TestBlocked(BSBBook: Record "BSB Book")
    begin
        BSBBook.TestField(Blocked, false);
    end;

    procedure ShowCard()
    begin
        ShowCard(Rec);
    end;

    procedure ShowCard(BookNo: Code[20])
    var
        BSBBook: Record "BSB Book";
    begin
        if not BSBBook.Get(BookNo) then
            exit;
        ShowCard(BSBBook);
    end;

    local procedure ShowCard(BSBBook: Record "BSB Book")
    begin
        Page.RunModal(Page::"BSB Book Card", BSBBook);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnDelete(var Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}
