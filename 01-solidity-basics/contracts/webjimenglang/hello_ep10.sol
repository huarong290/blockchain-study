// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第九节：数组操作
 *
 */
contract StructSectionEp19 {

    struct Student{
        uint id ;
        string name;
        uint sex;
        uint age;
        uint createAt;
    }
    Student[] students;

    modifier checkArrayOutofBounds(uint k){
        require(k< students.length,"out of bounds");
        _;
    }
    function add (Student memory item) public returns(Student memory){
        students.push(item);
        return item;
    }

    function modifyName(uint k , string memory name)public checkArrayOutofBounds(k) returns(Student memory){
        students[k].name = name;
        return  students[k];
    }

    function getStudent(uint k )public view  checkArrayOutofBounds(k) returns(Student memory){
        return  students[k];
    }

    function getStudentList() public view returns(Student[] memory){
        return students; 
    }
    function removeStudent(uint k)public checkArrayOutofBounds(k) returns(Student[] memory){
        Student memory holder;
        for(uint n ; n<students.length;n++){
            if(n>=k){
                students[n] = (n+1)>= students.length ? holder:students[n+1];
            }
        }
        students.pop();
        return students;
    }
    function removeStudent2(uint k) public checkArrayOutofBounds(k) returns (Student[] memory) {
        // 从 k 开始，直接用后面的覆盖前面的，直到倒数第二个元素
        for (uint n = k; n < students.length - 1; n++) {
            students[n] = students[n + 1];
        }
        // 弹出最后一个多余的元素
        students.pop();
        return students;
    }
    /**
     * 【更省 Gas 的删除替代方案】
     * 如果不在乎数组元素的原有顺序，推荐使用这种方式（用末尾元素覆盖要删除的位置）：
     */
    function removeStudentFast(uint k) public checkArrayOutofBounds(k) returns (Student[] memory) {
        students[k] = students[students.length - 1]; // 将最后一个元素盖到第 k 个
        students.pop(); // 弹出最后一个
        return students;
    }
}