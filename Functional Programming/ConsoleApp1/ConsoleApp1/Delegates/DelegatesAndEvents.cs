namespace ConsoleApp1.Delegates
{
    public class DelegatesAndEvents
    {
        public delegate void WorkPerformedHandler(int hours, WorkType workType);
    }

    public enum WorkType
    {
        GoToMeetings,
        Golf,
        GenerateReports,
    }
}