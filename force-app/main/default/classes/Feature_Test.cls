@IsTest
private class Feature_Test {
    @IsTest
    private static void isOn_notConfigured_returnsFalse() {
        Boolean isOn;
        System.Test.startTest();
        isOn = Feature.isOn('TestFeature');
        System.Test.stopTest();
        System.assertEquals(false, isOn);
    }

    @IsTest
    private static void isOn_mockedTrue_returnsTrue() {
        Feature.setMockFeatureFlag('TestFeature', true);
        Boolean isOn;
        System.Test.startTest();
        isOn = Feature.isOn('TestFeature');
        System.Test.stopTest();
        System.assertEquals(true, isOn);
    }

    @IsTest
    private static void isOn_mockedFalse_returnsFalse() {
        Feature.setMockFeatureFlag('TestFeature', false);
        Boolean isOn;
        System.Test.startTest();
        isOn = Feature.isOn('TestFeature');
        System.Test.stopTest();
        System.assertEquals(false, isOn);
    }
}
