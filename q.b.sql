------------- part 2 --------------
-- trigger functions
create or replace function trigf1() returns trigger as
$$
begin
    if exists(
            select car.lno
            from request , car
            where request.seats = car.seats
            AND request.rno= new.rno
            AND request.cid = new.cid
            AND (request.shift = car.shift OR request.boot = car.boot OR request.doors = car.doors)
    )
        then return new;
    else
        raise notice 'The vehicle does not match the order details';    
        return null;
    end if;

end;
$$ language plpgsql;

-- trigger
create trigger T1
    before insert
    ON rent
    for each row
execute procedure trigf1();