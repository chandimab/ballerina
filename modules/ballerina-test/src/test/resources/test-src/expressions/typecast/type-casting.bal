function floattoint(float value)(int) {
    int result;
    //float to int should be a conversion
    result = <int>value;
    return result;
}
 
function inttofloat(int value)(float) {
    float result;
    //int to float should be a conversion
    result = <float> value;
    return result;
}

function stringtoint(string value)(int) {
    int result;
    //string to int should be a unsafe conversion
    result, _ = <int>value;
    return result;
}

function testJsonIntToString() (string) {
    json j = 5;
    int value;
    value, _ = (int)j;
    return <string> value;
}

function stringtofloat(string value)(float) {
    float result;
    //string to float should be a conversion
    result, _ = <float>value;
    return result;
}

function inttostring(int value)(string) {
    string result;
    //int to string should be a conversion
    result = <string>value;
    return result;
}

function floattostring(float value)(string) {
    string result;
    //float to string should be a conversion
    result = <string>value;
    return result;
}

function booleantostring(boolean value)(string) {
    string result;
    //boolean to string should be a conversion
    result = <string>value;
    return result;
}

function booleanappendtostring(boolean value)(string) {
    string result;
    result = value + "-append-" + value;
    return result;
}

function intarrtofloatarr()(float[]) {
    float[] numbers;
    numbers = [999,95,889];
    return numbers;
}

function testJsonToStringCast() (string) {
    json j = "hello";
    string value;
    value, _ = (string)j;
    return value;
}

function testJSONObjectToStringCast() (string, TypeCastError) {
    json j = {"foo":"bar"};
    var value, e = (string)j;
    return value, e;
}

function testJsonToInt() (int){
    json j = 5;
    int value;
    value, _ = (int)j;
    return value;
}

function testJsonToFloat() (float){
    json j = 7.65;
    float value;
    value, _ = (float)j;
    return value;
}

function testJsonToBoolean() (boolean){
    json j = true;
    boolean value;
    value, _ = (boolean)j;
    return value;
}

function testStringToJson(string s) (json) {
    return s;
}

struct Person {
    string name;
    int age;
    map address;
    int[] marks;
    Person parent;
    json info;
    any a;
    float score;
    boolean alive;
}

struct Student {
    string name;
    int age;
    map address;
    int[] marks;
}

function testStructToStruct() (Student) {
    Person p = { name:"Supun",
                   age:25,
                   parent:{name:"Parent", age:50},
                   address:{"city":"Kandy", "country":"SriLanka"},
                   info:{status:"single"},
                   marks:[24, 81]
               };
    return (Student) p;
}

function testNullStructToStruct() (Student) {
    Person p;
    return (Student) p;
}

function testStructAsAnyToStruct() (Person) {
    Person p1 = { name:"Supun",
                    age:25,
                    parent:{name:"Parent", age:50},
                    address:{"city":"Kandy", "country":"SriLanka"},
                    info:{status:"single"},
                    marks:[24, 81]
                };
    any a = p1;
    Person p2;
    p2, _ = (Person) a;
    return p2;
}

function testAnyToStruct() (Person) {
    any a = { name:"Supun",
                age:25,
                parent:{name:"Parent", age:50},
                address:{"city":"Kandy", "country":"SriLanka"},
                info:{status:"single"},
                marks:[24, 81]
            };
    Person p2;
    TypeCastError e;
    p2, e = (Person) a;
    if (e != null) {
        throw e;
    }
    return p2;
}

function testAnyNullToStruct() (Person) {
    any a;
    Person p;
    p, _ = (Person) a;
    return p;
}

function testStructToAnyExplicit() (any) {
    Person p = { name:"Supun",
                   age:25,
                   parent:{name:"Parent", age:50},
                   address:{"city":"Kandy", "country":"SriLanka"},
                   info:{status:"single"},
                   marks:[24, 81]
               };
    return (any) p;
}

function testMapToAnyExplicit() (any) {
    map m = {name:"supun"};
    return (any) m;
}

function testBooleanInJsonToInt() (int) {
    json j = true;
    int value;
    TypeCastError e;
    value, e = (int)j;
    if (e != null) {
        throw e;
    }
    return value;
}

function testIncompatibleJsonToInt() (int) {
    json j = "hello";
    int value;
    TypeCastError e;
    value, e = (int)j;
    if (e != null) {
        throw e;
    }
    return value;
}

function testIntInJsonToFloat() (float) {
    json j = 7;
    float value;
    TypeCastError e;
    value, e = (float)j;
    if (e != null) {
        throw e;
    }
    return value;
}

function testIncompatibleJsonToFloat() (float) {
    json j = "hello";
    float value;
    TypeCastError e;
    value, e = (float)j;
    if (e != null) {
        throw e;
    }
    return value;
}

function testIncompatibleJsonToBoolean() (boolean) {
    json j = "hello";
    boolean value;
    TypeCastError e;
    value, e = (boolean)j;
    if (e != null) {
        throw e;
    }
    return value;
}

struct Address {
    string city;
    string country;
}

function testNullJsonToString() (string) {
    json j;
    string value;
    value, _ = (string)j;
    return value;
}

function testNullJsonToInt() (int) {
    json j;
    int value;
    value, _ = (int)j;
    return value;
}

function testNullJsonToFloat() (float) {
    json j;
    float value;
    value, _ = (float)j;
    return value;
}

function testNullJsonToBoolean() (boolean) {
    json j;
    boolean value;
    value, _ = (boolean)j;
    return value;
}

function testAnyIntToJson() (json) {
    any a = 8;
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyStringToJson() (json) {
    any a = "Supun";
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyBooleanToJson() (json) {
    any a = true;
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyFloatToJson() (json) {
    any a = 8.73;
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyMapToJson() (json) {
    map m = {name:"supun"};
    any a = m;
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyStructToJson() (json) {
    Address adrs = {city:"CA"};
    any a = adrs;
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyNullToJson() (json) {
    any a = null;
    json value;
    value, _ = (json) a;
    return value;
}

function testAnyJsonToJson() (json) {
    json j = {home:"SriLanka"};
    any a = j;
    json value;
    value, _ = (json) a;
    return value;
}

function testAnyArrayToJson() (json) {
    any a = [8,4,6];
    json value;
    TypeCastError e;
    value, e = (json) a;
    if (e != null) {
        throw e;
    }
    return value;
}

function testAnyNullToMap() (map) {
    any a;
    map value;
    value, _ = (map) a;
    return value;
}

function testAnyNullToXml() (xml) {
    any a;
    xml value;
    value, _ = (xml) a;
    return value;
}

struct A {
    string x;
    int y;
}

struct B {
    string x;
}

function testCompatibleStructForceCasting()(A, TypeCastError) {
    A a = {x: "x-valueof-a", y:4};
    B b = {x: "x-valueof-b"};
    A c;

    b = (B) a;
    TypeCastError err;
    c, err = (A) b;

    a.x = "updated-x-valueof-a";
    return c, err;
}

function testInCompatibleStructForceCasting()(A, TypeCastError) {
    B b = {x: "x-valueof-b"};
    A a;
    TypeCastError err;
    a, err = (A) b;

    return a, err;
}

function testAnyToStringWithErrors()(string, TypeCastError) {
    any a = 5; 
    string s;
    TypeCastError err;
    s, err = (string) a;
    
    return s, err;
}

function testAnyToStringWithoutErrors()(string, TypeCastError) {
    any a = "value";
    string s;
    TypeCastError err;
    s, err = (string) a;

    return s, err;
}

function testAnyToIntWithoutErrors()(int, TypeCastError) {
    any a = 6;
    int s;
    TypeCastError err;
    s, err = (int) a;

    return s, err;
}

function testAnyToFloatWithoutErrors()(float, TypeCastError) {
    any a = 6.99;
    float s;
    TypeCastError err;
    s, err = (float) a;

    return s, err;
}

function testAnyToBooleanWithoutErrors()(boolean, TypeCastError) {
    any a = true;
    boolean s;
    TypeCastError err;
    s, err = (boolean) a;

    return s, err;
}

function testAnyToBooleanWithErrors()(boolean, TypeCastError) {
    any a = 5; 
    boolean b;
    TypeCastError err;
    b, err = (boolean) a;
    
    return b, err;
}

function testAnyNullToBooleanWithErrors()(boolean, TypeCastError) {
    any a = null; 
    boolean b;
    TypeCastError err;
    b, err = (boolean) a;
    
    return b, err;
}

function testAnyToIntWithErrors()(int, TypeCastError) {
    any a = "foo"; 
    int b;
    TypeCastError err;
    b, err = (int) a;
    
    return b, err;
}

function testAnyNullToIntWithErrors()(int, TypeCastError) {
    any a = null; 
    int b;
    TypeCastError err;
    b, err = (int) a;
    
    return b, err;
}

function testAnyToFloatWithErrors()(float, TypeCastError) {
    any a = "foo"; 
    float b;
    TypeCastError err;
    b, err = (float) a;
    
    return b, err;
}

function testAnyNullToFloatWithErrors()(float, TypeCastError) {
    any a = null; 
    float b;
    TypeCastError err;
    b, err = (float) a;
    
    return b, err;
}

function testAnyToMapWithErrors()(map, TypeCastError) {
    any a = "foo"; 
    map b;
    TypeCastError err;
    b, err = (map) a;
    
    return b, err;
}

function testAnyNullToStringWithErrors()(string, TypeCastError) {
    any a = null;
    string s;
    TypeCastError err;
    s, err = (string) a;

    return s, err;
}

function testSameTypeCast() (int) {
    int a = 10;

    int b = (int) a;
    return b;
}

function testErrorOnCasting() (TypeCastError, TypeCastError, TypeCastError, TypeCastError) {

    // json to string
    json j1 = "hello";
    var s, err1 = (string) j1;

    // json to int
    json j2 = 4;
    var i, err2 = (int) j2; 

    // json to float
    json j3 = 4.2;
    var f, err3 = (float) j3; 

    // json to boolean
    json j4 = true;
    var b, err4 = (boolean) j4;

    return err1, err2, err3, err4;
}
