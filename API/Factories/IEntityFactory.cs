namespace API.Factories
{
    public interface IEntityFactory<T>
    {
        T CreateEntity(object[] objects);
    }
}
