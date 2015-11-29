use sqlr
go
drop procedure if exists Survival_by_Age1;
go
create procedure Survival_by_Age1
as
begin

	exec sp_execute_external_script
		  @language = N'R',
		  @script = N'

require(ggplot2)

train <- data.frame(InputDataSet)
#print("Semmy Wellem Taju");

png("1_Survival_by_Age.png", width=800, height=600)
hist(train$Age[which(train$Survived == FALSE)], main= "Passenger Age Histogram", xlab="Age", ylab="Count", col =3,
     breaks=seq(0,80,by=2))
hist(train$Age[which(train$Survived == TRUE)], col =2, add = T, breaks=seq(0,80,by=2))

dev.off()
imgfile <- file("1_Survival_by_Age.png", "rb");
image1 <- readBin(imgfile, what=raw(), n=1e6);
close(imgfile);

OutputDataSet <- data.frame(data=image1);
',
		  @input_data_1 = N'SELECT [PassengerId],[Survived],[Pclass],[Name],[Sex],Convert(int,[Age])as Age,[SibSp],[Parch],[Ticket],[Fare],[Cabin],[Embarked] FROM [dbo].[TitanicTrain];'
	with result sets(([chart1] varbinary(max)));

end;
