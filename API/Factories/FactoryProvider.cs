﻿using API.Entities;
using API.Factories;

public class FactoryProvider
{
    public static IEntityFactory<T> GetFactory<T>() where T : class
    {
        if (typeof(T) == typeof(Student))
        {
            return (IEntityFactory<T>) new StudentFactory();
        }
        else if (typeof(T) == typeof(Lesson))
        {
            return (IEntityFactory<T>)new LessonFactory();
        }
        else

            throw new NotImplementedException($"No factory available for type {typeof(T).Name}");
    }
}
