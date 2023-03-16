create or alter procedure CreateSchedule (@StaffID int, @AppointmentNameID int, @AppointmentDate date, @AppointmentStartTime time, @AppointmentEndTime time, @DurationMins int, @MaxParticipants int)
as
	Declare @ReturnCode int
	set @ReturnCode = 1
if @AppointmentDate is NULL
	Begin
		RAISERROR('CreateSchedule - @AppointmentDate is Required', 16, 1)
	End
Else
	if @StaffID is NULL
			Begin
				RAISERROR('CreateSchedule - @StaffID is Required', 16, 1)
			End
	Else
		if not exists (select StaffID from Staff where StaffID = @StaffID)
			Begin
				RAISERROR('CreateSchedule - Staff Member does not exist', 16, 1)
			End
		Else
			if @AppointmentNameID is NULL
				Begin
					RAISERROR('CreateSchedule - @AppointmentNameID is Required', 16, 1)
				End
			Else
				if not exists (select AppointmentNameID from AppointmentName where AppointmentNameID = @AppointmentNameID)
					Begin
						RAISERROR('CreateSchedule - Appointment Name does not exist', 16, 1)
					End
				Else
					if @AppointmentDate is NULL
						Begin
							RAISERROR('CreateSchedule - @AppointmentDate is Required', 16, 1)
						End
					Else
						if @AppointmentStartTime is NULL
							Begin
								RAISERROR('CreateSchedule - @AppointmentStartDate is Required', 16, 1)
							End
						 Else
							if @AppointmentEndTime is NULL
								Begin
									RAISERROR('CreateSchedule - @AppointmentEndDate is Required', 16, 1)
								End
							Else
								if @DurationMins is NULL
									Begin
										RAISERROR('CreateSchedule - @DurationMins is Required', 16, 1)
									End
								Else
									if @MaxParticipants is NULL
										Begin
											RAISERROR('CreateSchedule - @MaxParticipants is Required', 16, 1)
										End
									Else
										Begin
											insert into Schedule(StaffID, AppointmentNameID, AppointmentDate, AppointmentStartTime, AppointmentEndTime, DurationMins, TotalNumberOfParticipants, MaxParticipants, Status)
														values (@StaffID, @AppointmentNameID, @AppointmentDate, @AppointmentStartTime, @AppointmentEndTime, @DurationMins, 0, @MaxParticipants, 1)
										if @@ERROR = 0
											set @ReturnCode = 0
										Else
											RAISERROR('CreateSchedule - CreateSchedule Error from Schedule Table', 16, 1)
										End
Return @ReturnCode