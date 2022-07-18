void main()
{
object oDrop = GetModuleItemLost();
DelayCommand(300.0f,ExecuteScript("cleanup",oDrop));//dropped item cleanup
}


