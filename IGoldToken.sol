pragma solidity ^0.4.11;
import './IERC20.sol';
library SafeMath {
    function mul(uint256 a, uint256 b) internal constant returns(uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal constant returns(uint256) {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal constant returns(uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal constant returns(uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
contract IGoldToken is IERC20 {
using SafeMath
    for uint256;
    uint public constant _totalSupply = 500000000000000;
    string public constant symbol = "IGP";
    string public constant name = "IGoldPro";
    uint8 public constant decimals = 8;
    
    
    mapping(address => uint256) balances;
    mapping(address=> mapping(address=> uint256)) allowed;
    function IGoldToken(){
        balances[msg.sender] = _totalSupply;
    }
    function totalSupply() constant returns (uint256 totalSupply){
        return _totalSupply;
        
    }
    function balanceOf(address _owner) constant returns (uint256 balance){
        return balances[_owner];
    }
    function transfer(address _to, uint256 _value) returns (bool success){
        require(
                balances[msg.sender] >= _value
                &&  _value > 0
            );
            
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
        
    }
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success){
        require(
                allowed[_from][msg.sender] >= _value
                && balances[_from] >= _value
                && _value > 0
            );
            
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] =- _value;
        Transfer(_from, _to, _value);
        return true;
        
    }
    function approve(address _spender, uint256 _value) returns (bool success){
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
        
    }
    function allowance(address _owner, address _spender) constant returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
