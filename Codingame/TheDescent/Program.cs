using System;
using System.Linq;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;

/**
 * The while loop represents the game.
 * Each iteration represents a turn of the game
 * where you are given inputs (the heights of the mountains)
 * and where you have to print an output (the index of the mountain to fire on)
 * The inputs you are given are automatically updated according to your last actions.
 **/
class Player
{
    static void Main(string[] args)
    {
        while (true)
        {
            Dictionary<int, int> mountainsHeightDict = new Dictionary<int, int>();
            for (int i = 0; i < 8; i++)
            {
                int mountainH = int.Parse(Console.ReadLine()); // represents the height of one mountain.
                mountainsHeightDict[i] = mountainH;
            }
            // source: https://stackoverflow.com/questions/10290838/how-to-get-max-value-from-dictionary
            var mountainToShoot = mountainsHeightDict
                .Aggregate((x, y) => x.Value > y.Value ? x : y).Key;
            Console.WriteLine(mountainToShoot); // The index of the mountain to fire on.
            mountainsHeightDict.Remove(mountainToShoot);
        }
    }
}