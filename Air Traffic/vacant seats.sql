--Find vacant seats for all flights

with vacant_seats as ( --создаём CTE "свободные кресла"
	select f.flight_id, s.seat_no as vacant_seat --отображаем все кресла на каждом flight_id
	from flights f
	join aircrafts a on a.aircraft_code = f.aircraft_code 
	join seats s on s.aircraft_code = a.aircraft_code 
		except --убираем из вывода те кресла, на которые были выданы посадочные талоны (т.е. пассажир пришёл на рейс и занял это место)
	select bp.flight_id, bp.seat_no
	from boarding_passes bp 
	order by flight_id 
)
select f.flight_no, vacant_seats.flight_id, vacant_seats.vacant_seat
from vacant_seats 
join flights f on f.flight_id = vacant_seats.flight_id
