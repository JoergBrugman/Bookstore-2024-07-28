codeunit 50111 "BSB Book Type Hardcover Impl."
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