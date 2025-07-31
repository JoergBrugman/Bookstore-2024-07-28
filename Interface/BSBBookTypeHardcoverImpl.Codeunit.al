codeunit 50111 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Pick from bin');
    end;

    procedure StartDeliverBook()
    begin
        Message('UPS Premium');
    end;
}