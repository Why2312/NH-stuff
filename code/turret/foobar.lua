type TypelessParts = "Wood" | "Ascendium" | "Cooler" | "Lead" | "HeatPipe" | "Water" | "WaterCooler" | "Havocrym" | "ExoticMatter" | "ReinforcedGlass" | "BurnerGenerator" | "Fence" | "Saw" | "Silver" | "Medkit" | "MustardGas" | "Grenade" | "ElectricFence" | "EnergyBomb" | "AlienFruit" | "Diode" | "Neon" | "EnergyGun" | "Ball" | "Sinister" | "Prismonite" | "SteamTurbine" | "Decimator" | "Phasite" | "NetLauncher" | "AlienFruitZ" | "Obsidian" | "Crate" | "AlienFruitB" | "Cleat" | "THEROCK" | "GoldenSpeaker" | "Pistol" | "Melter" | "Emerald" | "AluminumPowercell" | "Tetra" | "OmniGenerator" | "Quartz" | "AmplifiedElectricFence" | "InnerCorner" | "Plutonium" | "HeatPump" | "Cloth" | "Wheel" | "Stone" | "StarOre" | "Mannequin" | "RoundWedge" | "ForbiddenTorch" | "TriggerWire" | "RTG" | "Adamantium" | "Aluminum" | "Sprinkler" | "Decoupler" | "DemonRifle" | "Radium" | "Clip" | "Snow" | "Heater" | "SolarPanel" | "RepairKit" | "Igniter" | "Vitarite" | "OmniBattery" | "Scrapper" | "Steam" | "Pyramid" | "Glass" | "RepairLaser" | "CornerTetra" | "Gear" | "Wedge" | "Pipe" | "EthernetCable" | "NightVisionGoggles" | "CombustionTurbine" | "Gasoline" | "HealingField" | "Coal" | "Cylinder" | "FireWood" | "Electrolyzer" | "Container" | "ConcussionBomb" | "Petroleum" | "AlienFruitC" | "Chute" | "Ice" | "Battery" | "Coupler" | "Hemisphere" | "Lava" | "Rubber" | "ConvexCorner" | "Kiln" | "Hate" | "Pumpkin" | "Hopper" | "Seat" | "StarStone" | "Plastic" | "Copper" | "Ramp" | "ImpulseCannon" | "Freezer" | "InternetCard" | "ConcaveRamp" | "LithiumPowercell" | "Goggles" | "Ruby" | "Sword" | "ATOMIZER" | "Flint" | "Wire" | "Flare" | "Diamond" | "InnerCornerRound" | "Fuse" | "HollowCylinder" | "AirSupply" | "CornerRamp" | "Grass" | "ManualGenerator" | "Sulfur" | "Jade" | "Hydrogen" | "Helixite" | "Truss" | "CornerRound" | "LeadGlass" | "TouchSensor" | "Pulverizer" | "Indicator" | "Refinery" | "AlienFruitD" | "ImperialDecimator" | "Microphone" | "Gold" | "Lithium" | "Sand" | "OmniFence" | "GasHeater" | "Explosive" | "Sorter" | "Cone" | "FireExtinguisher" | "ZapWire" | "RepairGun" | "Laser" | "Skull" | "BisectedCornerRight" | "Powercell" | "Shotgun" | "Titanium" | "DarkMatter" | "Sniper" | "Oil" | "FlareLauncher" | "Uranium" | "CornerPiece" | "Iron" | "BisectedCornerLeft" | "CornerWedge" | "Helium" | "AdminGun" | "Plasma" | "SMG" | "Phantomite" | "NuclearWaste" | "SSDExpansion" | "Food" | "Boiler" | "SmokeBomb" | "Silicon" | "Drainer" | "CollectorRay" | "Socket"

type GetPart<I, O> = (self: Part, partType: I) -> O
type GetParts<I, O> = (self: Part, partType: I) -> {O}

type JSONValue = boolean | string | number
type JSON = { [JSONValue]: JSONValue } | JSONValue



export type CharacterBase = {
	Name: string,
	ID: number,

	Health: number,
	MaxHealth: number,
	
	CFrame: CFrame,
	Position: Vector3,
	Orientation: Vector3,
	AssemblyAngularVelocity: Vector3,
	AssemblyLinearVelocity: Vector3,

	WalkSpeed: number,
	JumpPower: number,
	JumpHeight: number,

	Jump: boolean,
	Sit: boolean,
	PlatformStand: boolean,
	HipHeight: number,
	
	Skin: {
		RightArm: Color3,
		LeftArm: Color3,
		Head: Color3,
		Torso: Color3,
		RightLeg: Color3,
		LeftLeg: Color3,
	},
}

export type Character = {
	Skin: {
		RightArm: Color3,
		LeftArm: Color3,
		Head: Color3,
		Torso: Color3,
		RightLeg: Color3,
		LeftLeg: Color3,
	},
} & CharacterBase



export type RaycastCharacter = {
	Type: "Humanoid",
	Limb: string,
	LimColor: Color3
} & CharacterBase

export type RaycastPart = {
	Type: "Part"
}

export type RaycastTerrain = {
	Type: "Terrain"
}

export type RaycastResult = RaycastCharacter | RaycastPart | RaycastTerrain



export type CursorBase = {
	Player: string,
	Pressed: boolean,
	X: number,
	Y: number,
}

export type Cursor = {
	XScale: number,
	YScale: number,
} & CursorBase

export type ARCursor = {
	Hit: CFrame,
	CameraCFrame: CFrame,
	Target: RaycastResult
} & CursorBase



export type InternetCard = {
	NetworkId: number,
	
	PostRequest: (self: InternetCard, domain: string, data: any, password: string) -> "Success" | "Fail",
	GetRequest: (self: InternetCard, domain: string) -> any,
	RealPostRequest: (self: InternetCard, url: string, data: string, contentType: Enum.HttpContentType, compress: boolean, headers: any) -> string,
	RealGetRequest: (self: InternetCard, url: string, nocache: boolean, headers: any) -> string,
	Send: (self: InternetCard, ...any) -> (),
	
	DataReceived: RBXScriptSignal
}

export type BluetoothCard = {
	NetworkId: number,
	
	GetAR: (self: BluetoothCard) -> {ARGoggles},
	Send: (self: BluetoothCard, ...any) -> (),
	
	DataReceived: RBXScriptSignal,
}

export type SSDCard = {
	Name: nil
} & Disk



export type Part = {
	Name: string,
	GUID: "None",
	Anchored: boolean,
	Size: Vector3,
	Color: Color3,
	Transparency: number,
	Health: number,
	Temperature: number,

	Trigger: (self: Part) -> (),

	Triggered: RBXScriptSignal,
}

export type Any = {
	Configure: (self: Part, configuration: { [string]: any }) -> (),
	[string]: any,
} & Part



export type Port = {
	Name: "Port",
	GUID: string,
	PortID: number?,

	Configure: (self: Port, configuration: { PortID: number? }) -> (),
	Send: (self: Port, ...any) -> (),

	GetPart: GetPart<"Disk", Disk>
		& GetPart<"LifeSensor", LifeSensor>
		& GetPart<"FireDetector", FireDetector>
		& GetPart<"Fabricator", Fabricator>
		& GetPart<"Instrument", Instrument>
		& GetPart<"Screen", Screen>
		& GetPart<"TouchScreen", TouchScreen>
		& GetPart<"TransparentScreen", TransparentScreen>
		& GetPart<"Light", Light>
		& GetPart<"LightTube", LightTube>
		& GetPart<"Spotlight", Spotlight>
		& GetPart<"GeigerCounter", GeigerCounter>
		& GetPart<"Gyro", Gyro>
		& GetPart<"Keyboard", Keyboard>
		& GetPart<"RemoteControl", RemoteControl>
		& GetPart<"HyperDrive", HyperDrive>
		& GetPart<"Servo", Servo>
		& GetPart<"Raycaster", Raycaster>
		& GetPart<"Computer", Computer>
		& GetPart<"Telescope", Telescope>
		& GetPart<"StarMap", StarMap>
		& GetPart<"Speaker", Speaker>
		& GetPart<"Hatch", Hatch>
		& GetPart<"Apparel", Apparel>
		& GetPart<"Painter", Painter>
		& GetPart<"Filter", Filter>
		& GetPart<"Antenna", Antenna>
		& GetPart<"Teleporter", Teleporter>
		& GetPart<"Conveyor", Conveyor>
		& GetPart<"Coat", Coat>
		& GetPart<"TimeSensor", TimeSensor>
		& GetPart<"RegionMap", RegionMap>
		& GetPart<"WPT", WPT>
		& GetPart<"Repeater", Repeater>
		& GetPart<"Transformer", Transformer>
		& GetPart<"Aligner", Aligner>
		& GetPart<"Winch", Winch>
		& GetPart<"Transporter", Transporter>
		& GetPart<"Motor", Motor>
		& GetPart<"Prosthetic", Prosthetic>
		& GetPart<"TriggerSwitch", TriggerSwitch>
		& GetPart<"SpawnPoint", SpawnPoint>
		& GetPart<"ImpactBomb", ImpactBomb>
		& GetPart<"Drill", Drill>
		& GetPart<"PowerSensor", PowerSensor>
		& GetPart<"LargeIonRocket", LargeIonRocket>
		& GetPart<"Rail", Rail>
		& GetPart<"Polysilicon", Polysilicon>
		& GetPart<"Faucet", Faucet>
		& GetPart<"ControlSeat", ControlSeat>
		& GetPart<"Thruster", Thruster>
		& GetPart<"TemperatureSensor", TemperatureSensor>
		& GetPart<"MiningLaser", MiningLaser>
		& GetPart<"IonRocket", IonRocket>
		& GetPart<"Router", Router>
		& GetPart<"ItemProjector", ItemProjector>
		& GetPart<"Extractor", Extractor>
		& GetPart<"RemoteSeat", RemoteSeat>
		& GetPart<"Button", Button>
		& GetPart<"AltitudeSensor", AltitudeSensor>
		& GetPart<"ImpactSensor", ImpactSensor>
		& GetPart<"Valve", Valve>
		& GetPart<"Door", Door>
		& GetPart<"Engine", Engine>
		& GetPart<"Excavator", Excavator>
		& GetPart<"Dispenser", Dispenser>
		& GetPart<"DarkRocket", DarkRocket>
		& GetPart<"CooldownGate", CooldownGate>
		& GetPart<"StorageSensor", StorageSensor>
		& GetPart<"Remote", Remote>
		& GetPart<"AlienTech", AlienTech>
		& GetPart<"Tracker", Tracker>
		& GetPart<"Anchor", Anchor>
		& GetPart<"Hydroponic", Hydroponic>
		& GetPart<"GravityGenerator", GravityGenerator>
		& GetPart<"Sign", Sign>
		& GetPart<"PowerGate", PowerGate>
		& GetPart<"SpeedSensor", SpeedSensor>
		& GetPart<"WirelessButton", WirelessButton>
		& GetPart<"Switch", Switch>
		& GetPart<"Handle", Handle>
		& GetPart<"DelayGate", DelayGate>
		& GetPart<"Rocket", Rocket>
		& GetPart<"AdvancedExtractor", AdvancedExtractor>
		& GetPart<TypelessParts | string, Any>,

	GetParts: GetParts<"Disk", Disk>
		& GetParts<"LifeSensor", LifeSensor>
		& GetParts<"FireDetector", FireDetector>
		& GetParts<"Fabricator", Fabricator>
		& GetParts<"Instrument", Instrument>
		& GetParts<"Screen", Screen>
		& GetParts<"TouchScreen", TouchScreen>
		& GetParts<"TransparentScreen", TransparentScreen>
		& GetParts<"Light", Light>
		& GetParts<"LightTube", LightTube>
		& GetParts<"Spotlight", Spotlight>
		& GetParts<"GeigerCounter", GeigerCounter>
		& GetParts<"Gyro", Gyro>
		& GetParts<"Keyboard", Keyboard>
		& GetParts<"RemoteControl", RemoteControl>
		& GetParts<"HyperDrive", HyperDrive>
		& GetParts<"Servo", Servo>
		& GetParts<"Raycaster", Raycaster>
		& GetParts<"Computer", Computer>
		& GetParts<"Telescope", Telescope>
		& GetParts<"StarMap", StarMap>
		& GetParts<"Speaker", Speaker>
		& GetParts<"Hatch", Hatch>
		& GetParts<"Apparel", Apparel>
		& GetParts<"Painter", Painter>
		& GetParts<"Filter", Filter>
		& GetParts<"Antenna", Antenna>
		& GetParts<"Teleporter", Teleporter>
		& GetParts<"Conveyor", Conveyor>
		& GetParts<"Coat", Coat>
		& GetParts<"TimeSensor", TimeSensor>
		& GetParts<"RegionMap", RegionMap>
		& GetParts<"WPT", WPT>
		& GetParts<"Repeater", Repeater>
		& GetParts<"Transformer", Transformer>
		& GetParts<"Aligner", Aligner>
		& GetParts<"Winch", Winch>
		& GetParts<"Transporter", Transporter>
		& GetParts<"Motor", Motor>
		& GetParts<"Prosthetic", Prosthetic>
		& GetParts<"TriggerSwitch", TriggerSwitch>
		& GetParts<"SpawnPoint", SpawnPoint>
		& GetParts<"ImpactBomb", ImpactBomb>
		& GetParts<"Drill", Drill>
		& GetParts<"PowerSensor", PowerSensor>
		& GetParts<"LargeIonRocket", LargeIonRocket>
		& GetParts<"Rail", Rail>
		& GetParts<"Polysilicon", Polysilicon>
		& GetParts<"Faucet", Faucet>
		& GetParts<"ControlSeat", ControlSeat>
		& GetParts<"Thruster", Thruster>
		& GetParts<"TemperatureSensor", TemperatureSensor>
		& GetParts<"MiningLaser", MiningLaser>
		& GetParts<"IonRocket", IonRocket>
		& GetParts<"Router", Router>
		& GetParts<"ItemProjector", ItemProjector>
		& GetParts<"Extractor", Extractor>
		& GetParts<"RemoteSeat", RemoteSeat>
		& GetParts<"Button", Button>
		& GetParts<"AltitudeSensor", AltitudeSensor>
		& GetParts<"ImpactSensor", ImpactSensor>
		& GetParts<"Valve", Valve>
		& GetParts<"Door", Door>
		& GetParts<"Engine", Engine>
		& GetParts<"Excavator", Excavator>
		& GetParts<"Dispenser", Dispenser>
		& GetParts<"DarkRocket", DarkRocket>
		& GetParts<"CooldownGate", CooldownGate>
		& GetParts<"StorageSensor", StorageSensor>
		& GetParts<"Remote", Remote>
		& GetParts<"AlienTech", AlienTech>
		& GetParts<"Tracker", Tracker>
		& GetParts<"Anchor", Anchor>
		& GetParts<"Hydroponic", Hydroponic>
		& GetParts<"GravityGenerator", GravityGenerator>
		& GetParts<"Sign", Sign>
		& GetParts<"PowerGate", PowerGate>
		& GetParts<"SpeedSensor", SpeedSensor>
		& GetParts<"WirelessButton", WirelessButton>
		& GetParts<"Switch", Switch>
		& GetParts<"Handle", Handle>
		& GetParts<"DelayGate", DelayGate>
		& GetParts<"Rocket", Rocket>
		& GetParts<"AdvancedExtractor", AdvancedExtractor>
		& GetParts<TypelessParts | string, Any>,

	DataReceived: RBXScriptSignal,

} & Part

export type Firewall = {
	Name: "Firewall",

	Ban: (self: Firewall, guid: string, password: string) -> (),
	Unban: (self: Firewall, guid: string, password: string) -> (),
	GetBans: (self: Firewall, password: string) -> {string},
	Reset: (self: Firewall, password: string) -> (),
	IsBanned: (self: Firewall, password: string) -> boolean,
	SetPassword: (self: Firewall, newPassword: string, password: string) -> (),

	FailedAttempt: RBXScriptSignal
} & Port



export type Machine = {
	Name: "Computer",
	GUID: string,
	
	Shutdown: (self: Machine) -> (),
	Send: (self: Machine, ...any) -> (),
	GetExpansions: (self: Machine) -> {
		Internet: InternetCard,
		Bluetooth: BluetoothCard,
		SSD: SSDCard
	},
	
	DataReceived: RBXScriptSignal,
} & Part

export type ARGoggles = {
	Name: "ARGoggles",
	ID: number?,

	GetCFrame: (self: ARGoggles) -> CFrame,
	GetHostData: (self: ARGoggles) -> RaycastCharacter,
	GetCursor: (self: ARGoggles) -> ARCursor,
	GetCanvas: (self: Screen) -> Frame,
	Clear: (self: Screen) -> (),

	Configure: (self: ARGoggles, configuration: { ID: number? }) -> (),

	CursorMoved: RBXScriptSignal,
	CursorPressed: RBXScriptSignal,
	CursorReleased: RBXScriptSignal,
} & Part

export type Disk = {
	Name: "Disk",
	
	Write: (self: Disk, key: any, value: any) -> (),
	Read: (self: Disk, key: any) -> any,
	ReadAll: (self: Disk) -> { [any]: any },
	Clear: (self: Disk) -> (),
} & Part

export type LifeSensor = {
	Name: "LifeSensor",
	
	GetReading: (self: LifeSensor) -> {Character}
} & Part

export type FireDetector = {
	Name: "FireDetector",
	Silent: boolean?,
	Range: number?,

	GetReading: (self: FireDetector) -> { { Name: string, CFrame: CFrame, Position: Vector3, Orientation: Vector3 } },

	Configure: (self: FireDetector, configuration: {
		Silent: boolean?,
		Range: number?,
	}) -> ()
} & Part

export type Fabricator = {
	Name: "Fabricator",
	ToCraft: string?,
	
	Craft: (self: Fabricator) -> (),

	Configure: (self: Fabricator, configuration: { ToCraft: string? }) -> ()
} & Part

export type Instrument = {
	Name: "Instrument",
	Mode: number?,
	
	GetReading: (self: Instrument, mode: number?) -> Vector3 & number,

	Configure: (self: Instrument, configuration: { Mode: number? }) -> ()
} & Part



export type Screen = {
	Name: "Screen",
	
	GetCanvas: (self: Screen) -> Frame,
	Clear: (self: Screen) -> ()
} & Part

export type TouchScreen = {
	Name: "TouchScreen",
	
	GetCursors: (self: TouchScreen) -> {Cursor},

	CursorMoved: RBXScriptSignal,
	CursorPressed: RBXScriptSignal,
	CursorReleased: RBXScriptSignal,
} & Screen

export type TransparentScreen = {
	Name: "TransparentScreen",
} & TouchScreen



export type Light = {
	Name: "Light",
	Brightness: number?,

	SetLightColor: (self: Light, color: Color3) -> (),
	GetLightColor: (self: Light) -> Color3,

	Configure: (self: Light, configuration: { Brightness: number? }) -> ()
} & Part

export type LightTube = {
	Name: "LightTube",
} & Light

export type Spotlight = {
	Name: "Spotlight",
	Range: number?,
	Brightness: number?,

	Configure: (self: Spotlight, configuration: {
		Range: number?,
		Brightness: number?,
	}) -> ()
} & Light



export type GeigerCounter = {
	Name: "GeigerCounter",
	Range: string?,

	GetReading: (self: GeigerCounter) -> number,

	Configure: (self: GeigerCounter, configuration: { Range: string? }) -> ()
} & Part

export type Gyro = {
	Name: "Gyro",
	Rotation: string?,
	MaxTorque: string?,
	Mode: number?,
	DisableOnUnpower: boolean?,
	TrackerID: number?,

	LookAtVector: (self: Gyro, vector: Vector3) -> (),
	LookAtAngle: (self: Gyro, angle: CFrame) -> (),

	Configure: (self: Gyro, configuration: {
		Rotation: string?,
		MaxTorque: string?,
		Mode: number?,
		DisableOnUnpower: boolean?,
		TrackerID: number?,
	}) -> ()
} & Part

export type Keyboard = {
	Name: "Keyboard",
	Mini: boolean?,

	SimulateTextInput: (self: Keyboard, text: string, player: string) -> (),
	SimulateKeyPress: (self: Keyboard, key: string, action: string, player: string) -> (),

	Configure: (self: Keyboard, configuration: { Mini: boolean? }) -> (),

	TextInputted: RBXScriptSignal,
	KeyPressed: RBXScriptSignal,
} & Part

export type RemoteControl = {
	Name: "RemoteControl",
	RemoteID: number?,

	GetOccupant: (self: RemoteControl) -> string,
	Eject: (self: RemoteControl) -> (),

	Configure: (self: RemoteControl, configuration: { RemoteID: number? }) -> ()
} & Part

export type HyperDrive = {
	Name: "HyperDrive",
	Destination: string?,

	GetRequiredPower: (self: HyperDrive) -> number,
	Configure: (self: HyperDrive, configuration: { Destination: string? }) -> ()
} & Part

export type Servo = {
	Name: "Servo",
	Responsiveness: number?,
	Angle: number?,
	Step: number?,
	Speed: number?,

	SetAngle: (self: Servo, angle: number) -> (),

	Configure: (self: Servo, configuration: {
		Responsiveness: number?,
		Angle: number?,
		Step: number?,
		Speed: number?,
	}) -> ()
} & Part

export type Raycaster = {
	Name: "Raycaster",
	RayTransparency: number?,

	GetReading: (self: Raycaster) -> RaycastResult?,

	Configure: (self: Raycaster, configuration: { RayTransparency: number? }) -> ()
} & Part

-- TODO:

export type Computer = {
	Name: "Computer",
	EjectExpansions: boolean?,
	ResetOnLoad: boolean?,
	Code: string?,

	Configure: (self: Computer, configuration: {
		EjectExpansions: boolean?,
		ResetOnLoad: boolean?,
		Code: string?,
	}) -> ()
} & Part

-- TODO,⠀Unknown⠀types⠀for⠀certain⠀functions

export type Telescope = {
	Name: "Telescope",
	View: string?,

	GetCoordinate: (self: Telescope, ...any) -> ...any,

	Configure: (self: Telescope, configuration: { View: string? }) -> ()
} & Part

export type StarMap = {
	Name: "StarMap",
	
	GetBodies: (self: StarMap) -> (),
	GetLocation: (self: StarMap) -> string,
	GetSystems: (self: StarMap) -> (),
}

export type Speaker = {
	Name: "Speaker",
	Sound: string?,

	Chat: (self: Speaker, ...any) -> (),
	Play: (self: Speaker, ...any) -> (),

	Configure: (self: Speaker, configuration: { Sound: string? }) -> ()
} & Part



export type Hatch = {
	Name: "Hatch",
	SwitchState: boolean?,

	Configure: (self: Hatch, configuration: { SwitchState: boolean? }) -> ()
} & Part

export type Apparel = {
	Name: "Apparel",
	Limb: string?,
	Transparency: number?,

	Configure: (self: Apparel, configuration: {
		Limb: string?,
		Transparency: number?,
	}) -> ()
} & Part

export type Painter = {
	Name: "Painter",
	PaintColor: string?,

	Configure: (self: Painter, configuration: { PaintColor: string? }) -> ()
} & Part

export type Filter = {
	Name: "Filter",
	Filter: string?,

	Configure: (self: Filter, configuration: { Filter: string? }) -> ()
} & Part

export type Antenna = {
	Name: "Antenna",
	AntennaID: string?,

	Configure: (self: Antenna, configuration: { AntennaID: string? }) -> ()
} & Part

export type Teleporter = {
	Name: "Teleporter",
	TeleporterID: string?,

	Configure: (self: Teleporter, configuration: { TeleporterID: string? }) -> ()
} & Part

export type Conveyor = {
	Name: "Conveyor",
	Speed: number?,

	Configure: (self: Conveyor, configuration: { Speed: number? }) -> ()
} & Part

export type Coat = {
	Name: "Coat",
	Transparency: number?,

	Configure: (self: Coat, configuration: { Transparency: number? }) -> ()
} & Part

export type TimeSensor = {
	Name: "TimeSensor",
	Range: string?,

	Configure: (self: TimeSensor, configuration: { Range: string? }) -> ()
} & Part

export type RegionMap = {
	Name: "RegionMap",
	Mode: number?,

	Configure: (self: RegionMap, configuration: { Mode: number? }) -> ()
} & Part

export type WPT = {
	Name: "WPT",
	WPTID: string?,

	Configure: (self: WPT, configuration: { WPTID: string? }) -> ()
} & Part

export type Repeater = {
	Name: "Repeater",
	Interval: number?,
	Iterations: number?,

	Configure: (self: Repeater, configuration: {
		Interval: number?,
		Iterations: number?,
	}) -> ()
} & Part

export type Transformer = {
	Name: "Transformer",
	Delay: number?,

	Configure: (self: Transformer, configuration: { Delay: number? }) -> ()
} & Part

export type Aligner = {
	Name: "Aligner",
	ZeroRotation: boolean?,

	Configure: (self: Aligner, configuration: { ZeroRotation: boolean? }) -> ()
} & Part

export type Winch = {
	Name: "Winch",
	Speed: number?,

	Configure: (self: Winch, configuration: { Speed: number? }) -> ()
} & Part

export type Transporter = {
	Name: "Transporter",
	TransporterID: string?,

	Configure: (self: Transporter, configuration: { TransporterID: string? }) -> ()
} & Part

export type Motor = {
	Name: "Motor",
	Power: number?,

	Configure: (self: Motor, configuration: { Power: number? }) -> ()
} & Part

export type Prosthetic = {
	Name: "Prosthetic",
	Limb: string?,

	Configure: (self: Prosthetic, configuration: { Limb: string? }) -> ()
} & Part

export type TriggerSwitch = {
	Name: "TriggerSwitch",
	SwitchState: boolean?,

	Configure: (self: TriggerSwitch, configuration: { SwitchState: boolean? }) -> ()
} & Part

export type SpawnPoint = {
	Name: "SpawnPoint",
	Public: boolean?,
	Label: string?,

	Configure: (self: SpawnPoint, configuration: {
		Public: boolean?,
		Label: string?,
	}) -> ()
} & Part

export type ImpactBomb = {
	Name: "ImpactBomb",
	MinForce: number?,

	Configure: (self: ImpactBomb, configuration: { MinForce: number? }) -> ()
} & Part

export type Drill = {
	Name: "Drill",
	ToExtract: string?,

	Configure: (self: Drill, configuration: { ToExtract: string? }) -> ()
} & Part

export type PowerSensor = {
	Name: "PowerSensor",
	Invert: boolean?,
	ActivateOnRegionLoad: boolean?,

	Configure: (self: PowerSensor, configuration: {
		Invert: boolean?,
		ActivateOnRegionLoad: boolean?,
	}) -> ()
} & Part

export type LargeIonRocket = {
	Name: "LargeIonRocket",
	Power: number?,

	Configure: (self: LargeIonRocket, configuration: { Power: number? }) -> ()
} & Part

export type Rail = {
	Name: "Rail",
	Speed: number?,
	Detach: boolean?,
	Reattach: boolean?,

	Configure: (self: Rail, configuration: {
		Speed: number?,
		Detach: boolean?,
		Reattach: boolean?,
	}) -> ()
} & Part

export type Polysilicon = {
	Name: "Polysilicon",
	Mode: number?,
	Amp: number?,
	Frequency: number?,

	Configure: (self: Polysilicon, configuration: {
		Mode: number?,
		Amp: number?,
		Frequency: number?,
	}) -> ()
} & Part

export type Faucet = {
	Name: "Faucet",
	FilterResource: string?,

	Configure: (self: Faucet, configuration: { FilterResource: string? }) -> ()
} & Part

export type ControlSeat = {
	Name: "ControlSeat",
	TurnSpeed: number?,
	RollControl: number?,
	HorizontalControl: number?,
	VerticalControl: number?,
	Enabled: boolean?,
	MouseControl: boolean?,

	Configure: (self: ControlSeat, configuration: {
		TurnSpeed: number?,
		RollControl: number?,
		HorizontalControl: number?,
		VerticalControl: number?,
		Enabled: boolean?,
		MouseControl: boolean?,
	}) -> ()
} & Part

export type Thruster = {
	Name: "Thruster",
	Power: number?,

	Configure: (self: Thruster, configuration: { Power: number? }) -> ()
} & Part

export type TemperatureSensor = {
	Name: "TemperatureSensor",
	Range: string?,
	IgnoreSurroundings: boolean?,

	Configure: (self: TemperatureSensor, configuration: {
		Range: string?,
		IgnoreSurroundings: boolean?,
	}) -> ()
} & Part

export type MiningLaser = {
	Name: "MiningLaser",
	ToExtract: string?,

	Configure: (self: MiningLaser, configuration: { ToExtract: string? }) -> ()
} & Part

export type IonRocket = {
	Name: "IonRocket",
	Power: number?,

	Configure: (self: IonRocket, configuration: { Power: number? }) -> ()
} & Part

export type Router = {
	Name: "Router",
	RouterID: string?,

	Configure: (self: Router, configuration: { RouterID: string? }) -> ()
} & Part

export type ItemProjector = {
	Name: "ItemProjector",
	Resource: string?,

	Configure: (self: ItemProjector, configuration: { Resource: string? }) -> ()
} & Part

export type Extractor = {
	Name: "Extractor",
	ToExtract: string?,

	Configure: (self: Extractor, configuration: { ToExtract: string? }) -> ()
} & Part

export type RemoteSeat = {
	Name: "RemoteSeat",
	TurnSpeed: number?,
	RollControl: number?,
	RemoteID: number?,
	VerticalControl: number?,
	Enabled: boolean?,
	MouseControl: boolean?,
	HorizontalControl: number?,

	Configure: (self: RemoteSeat, configuration: {
		TurnSpeed: number?,
		RollControl: number?,
		RemoteID: number?,
		VerticalControl: number?,
		Enabled: boolean?,
		MouseControl: boolean?,
		HorizontalControl: number?,
	}) -> ()
} & Part

export type Button = {
	Name: "Button",
	Keybind: string?,
	Mode: number?,

	Configure: (self: Button, configuration: {
		Keybind: string?,
		Mode: number?,
	}) -> ()
} & Part

export type AltitudeSensor = {
	Name: "AltitudeSensor",
	Range: string?,
	Mode: number?,

	Configure: (self: AltitudeSensor, configuration: {
		Range: string?,
		Mode: number?,
	}) -> ()
} & Part

export type ImpactSensor = {
	Name: "ImpactSensor",
	Range: string?,

	Configure: (self: ImpactSensor, configuration: { Range: string? }) -> ()
} & Part

export type Valve = {
	Name: "Valve",
	SwitchState: boolean?,

	Configure: (self: Valve, configuration: { SwitchState: boolean? }) -> ()
} & Part

export type Door = {
	Name: "Door",
	Open: boolean?,

	Configure: (self: Door, configuration: { Open: boolean? }) -> ()
} & Part

export type Engine = {
	Name: "Engine",
	Power: number?,

	Configure: (self: Engine, configuration: { Power: number? }) -> ()
} & Part

export type Excavator = {
	Name: "Excavator",
	ToExtract: string?,

	Configure: (self: Excavator, configuration: { ToExtract: string? }) -> ()
} & Part

export type Dispenser = {
	Name: "Dispenser",
	FilterResource: string?,
	Size: string?,

	Configure: (self: Dispenser, configuration: {
		FilterResource: string?,
		Size: string?,
	}) -> ()
} & Part

export type DarkRocket = {
	Name: "DarkRocket",
	Enabled: boolean?,
	Power: number?,

	Configure: (self: DarkRocket, configuration: {
		Enabled: boolean?,
		Power: number?,
	}) -> ()
} & Part

export type CooldownGate = {
	Name: "CooldownGate",
	Cooldown: number?,

	Configure: (self: CooldownGate, configuration: { Cooldown: number? }) -> ()
} & Part

export type StorageSensor = {
	Name: "StorageSensor",
	Range: string?,

	Configure: (self: StorageSensor, configuration: { Range: string? }) -> ()
} & Part

export type Remote = {
	Name: "Remote",
	Range: number?,

	Configure: (self: Remote, configuration: { Range: number? }) -> ()
} & Part

export type AlienTech = {
	Name: "AlienTech",
	Appearance: number?,

	Configure: (self: AlienTech, configuration: { Appearance: number? }) -> ()
} & Part

export type Tracker = {
	Name: "Tracker",
	ID: number?,

	Configure: (self: Tracker, configuration: { ID: number? }) -> ()
} & Part

export type Anchor = {
	Name: "Anchor",
	Anchored: boolean?,

	Configure: (self: Anchor, configuration: { Anchored: boolean? }) -> ()
} & Part

export type Hydroponic = {
	Name: "Hydroponic",
	Grow: number?,

	Configure: (self: Hydroponic, configuration: { Grow: number? }) -> ()
} & Part

export type GravityGenerator = {
	Name: "GravityGenerator",
	Gravity: number?,

	Configure: (self: GravityGenerator, configuration: { Gravity: number? }) -> ()
} & Part

export type Sign = {
	Name: "Sign",
	Text: string?,

	Configure: (self: Sign, configuration: { Text: string? }) -> ()
} & Part

export type PowerGate = {
	Name: "PowerGate",
	Invert: boolean?,

	Configure: (self: PowerGate, configuration: { Invert: boolean? }) -> ()
} & Part

export type SpeedSensor = {
	Name: "SpeedSensor",
	Range: string?,

	Configure: (self: SpeedSensor, configuration: { Range: string? }) -> ()
} & Part

export type WirelessButton = {
	Name: "WirelessButton",
	Keybind: string?,
	Mode: number?,

	Configure: (self: WirelessButton, configuration: {
		Keybind: string?,
		Mode: number?,
	}) -> ()
} & Part

export type Switch = {
	Name: "Switch",
	SwitchState: boolean?,

	Configure: (self: Switch, configuration: { SwitchState: boolean? }) -> ()
} & Part

export type Handle = {
	Name: "Handle",
	PointOffset: string?,
	Mode: number?,
	Point: boolean?,
	ThrowPower: number?,

	Configure: (self: Handle, configuration: {
		PointOffset: string?,
		Mode: number?,
		Point: boolean?,
		ThrowPower: number?,
	}) -> ()
} & Part

export type DelayGate = {
	Name: "DelayGate",
	Delay: number?,

	Configure: (self: DelayGate, configuration: { Delay: number? }) -> ()
} & Part

export type Rocket = {
	Name: "Rocket",
	Power: number?,

	Configure: (self: Rocket, configuration: { Power: number? }) -> ()
} & Part

export type AdvancedExtractor = {
	Name: "AdvancedExtractor",
	ToExtract: string?,

	Configure: (self: AdvancedExtractor, configuration: { ToExtract: string? }) -> ()
} & Part

return function(...): (
	Machine,
	(id: number) -> Port,
	(input: string) -> string,
	(data: JSON) -> string,
	(data: string) -> JSON,
	(pitch: number) -> ()
)
	return ...
end