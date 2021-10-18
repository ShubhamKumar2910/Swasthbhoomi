public class StringCustomUtility {
    public static Set<String> removeListFromList(Set<String> rawList,Set<String> sourceList){
        Set<String> tempList = new Set<String>();
        for(String str:rawList){
            if(!sourceList.contains(str))
            tempList.add(str);
        }
        return tempList;
    }
}