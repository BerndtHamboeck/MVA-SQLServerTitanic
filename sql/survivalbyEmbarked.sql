use sqlr
go
--exec Survival_by_Embarked;
--go
drop procedure if exists Survival_by_Embarked;
go
create procedure Survival_by_Embarked
as
begin

	exec sp_execute_external_script
		  @language = N'R',
		  @script = N'

require(ggplot2)

train <- data.frame(InputDataSet)
#print("Semmy Wellem Taju");


train$Survived <- factor(train$Survived, levels=c(TRUE,FALSE))
levels(train$Survived) <- c("Survived", "Died")
train$Pclass <- as.factor(train$Pclass)
levels(train$Pclass) <- c("1st Class", "2nd Class", "3rd Class")
train$Gender <- factor(train$Sex, levels=c("female", "male"))
levels(train$Gender) <- c("Female", "Male")


png("s8_survival_by_Embarked.png", width=800, height=600)
mosaicplot(train$Embarked ~ train$Survived, main="Passenger Survival by Embarked",
           color=c("#F51212", "#EBDEDE"), shade=FALSE,  xlab="", ylab="",
           off=c(0), cex.axis=1.4)
dev.off()


imgfile <- file("s8_survival_by_Embarked.png", "rb");
image1 <- readBin(imgfile, what=raw(), n=1e6);
close(imgfile);

OutputDataSet <- data.frame(data=image1);
',
		  @input_data_1 = N'SELECT [PassengerId],[Survived],[Pclass],[Name],[Sex],Convert(int,[Age])as Age,[SibSp],[Parch],[Ticket],[Fare],[Cabin],[Embarked] FROM [dbo].[TitanicTrain];'
	with result sets(([chart1] varbinary(max)));

end;



