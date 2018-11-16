
import Foundation


enum Accidental: String {
    case Sharp = "♯"
    case Flat  = "♭"
}

enum Note: CustomStringConvertible {
    case C(_: Accidental?)
    case D(_: Accidental?)
    case E(_: Accidental?)
    case F(_: Accidental?)
    case G(_: Accidental?)
    case A(_: Accidental?)
    case B(_: Accidental?)

    /**
     * This array contains all notes.
     */
    static let all: [Note] = [
            C(nil),   C(.Sharp),
            D(nil),
            E(.Flat), E(nil),
            F(nil),   F(.Sharp),
            G(nil),
            A(.Flat), A(nil),
            B(.Flat), B(nil)
     ]

    /**
     * This function returns the frequency of this note in the 4th octave.
     */
    var frequency: Double {
        let index = Note.all.indexOf({ $0 == self   })! -
                    Note.all.indexOf({ $0 == A(nil) })!

        return 440 * pow(2, Double(index) / 12.0)
    }

    /*
     * This property is used in the User Interface to show the name of this
     * note.
     */
    var description: String {
        let concat = { (letter: String, accidental: Accidental?) in
            return letter + (accidental != nil ? accidental!.rawValue : "")
        }

        switch self
        {
            case let C(a): return concat("C", a)
            case let D(a): return concat("D", a)
            case let E(a): return concat("E", a)
            case let F(a): return concat("F", a)
            case let G(a): return concat("G", a)
            case let A(a): return concat("A", a)
            case let B(a): return concat("B", a)
        }
    }
}

func ==(a: Note, b: Note) -> Bool {
    return a.description == b.description
}
