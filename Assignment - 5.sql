


CREATE FUNCTION factor(@number int)

RETURNS INT

AS

BEGIN

	DECLARE @i INT = 1, @result INT = 1

	WHILE (@i <= @number)

		BEGIN

			Set @result = @result * @i
			Set @i += 1

		END

	RETURN @result

END
;


SELECT dbo.factor(4);